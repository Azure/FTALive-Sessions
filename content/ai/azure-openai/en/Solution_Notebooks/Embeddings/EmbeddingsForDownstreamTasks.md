# Using Embeddings to Improve Downstream Tasks

GPT models have acquired lots of general knowledge during training, but often our use cases focus on a more specific topic area that GPT isn't specialized in. In this section we will go over how to use embeddings to improve results with few-shot prompt engineering methods. Using embeddings we can inject domain specific information into a prompt that will enable GPT to more successfully answer the question at hands.

## GPT - 3 General Knowledge

GPT-3 is extremely knowledgable language model as it is trained on billions of tokens scraped from across the internet. This results in GPT-3 having excellent knowledge about general topics or topics that can be easily found via a search engine lookup.

However, some use cases require domain specific expertise that GPT-3 was not trained specifically in. There are two ways to "teach" GPT-3 the specific knowledge required: finetuning or ehanced prompt engineering. Finetuning requires additional training, cost, and time by changing the model's weights. The second approach of enhanced prompt engineering does not require re training, and can improve upon GPT-3 inate capability of being able to search within a prompt to find the correct answer.

This notebook will focus on the second approach of enhancing prompt engineering to improve downstream tasks that require domain specific knowledge utilizing embeddings. Before jumping into an example, let's review the concept of embeddings below.

## Embeddings Refresher

An embedding is a special format of data representation that can be
easily utilized by machine learning models and algorithms. The embedding
is an information dense representation of the semantic meaning of a
piece of text. Each embedding is a vector of floating-point numbers,
such that the distance between two embeddings in the vector space is
correlated with semantic similarity between two inputs in the original
format. For example, if two texts are similar, then their vector
representations should also be similar.

Different Azure OpenAI embedding models are specifically created to be
good at a particular task. Similarity embeddings are good at capturing
semantic similarity between two or more pieces of text. Text search
embeddings help measure long documents are relevant to a short query.
Code search embeddings are useful for embedding code snippets and
embedding nature language search queries.

Embeddings make it easier to do machine learning on large inputs
representing words by capturing the semantic similarities in a vector
space. Therefore, we can use embeddings to if two text chunks are
semantically related or similar, and inherently provide a score to
assess similarity.

## Enhancing Prompt Engineering using Embeddings for Question Answering

Now we are ready to  walk through an example.

As we discussed, the base GPT models are extremely knowledgable, but may not know the ins and out of domain specific question. This example will focus on a topic from a newsarticle highlighted in the CNN/Daily Mail dataset, the 2015 Australian Fashion Report. A topic that GPT-3 may not be extremely familiar with.

Let's ask GPT a question about the report and see what it produces without any extensive prompt engineeing or finetuning to this domain to guague it's baseline knowledge.

```python
prompt = "Which clothing brands did the 2015 Australian Fashion Report expose for ongoing exploitation of overseas workers?"

openai.Completion.create(
    prompt=prompt,
    temperature=0,
    max_tokens=300,
    top_p=1,
    frequency_penalty=0,
    presence_penalty=0,
    engine="text-davinci-002"
)["choices"][0]["text"].strip(" \n")
```

This outputs: 'The 2015 Australian Fashion Report exposed a number of clothing brands for their ongoing exploitation of overseas workers. These brands included Kmart, Target, Big W, and Cotton On.'

However the correct answer is the clothing brands that were exposed were Lowes, Industrie, Best & Less and the Just Group. GPT-3 needs assistance here to avoid hallucinations. We rather the model tell us they do not know rather than haullicate. This is essential so we can trust the responses provided by the model.

Let's try adding in a statement in our prompt to explicitly state to avoid hallucinations.

```python
prompt = """Answer the question as truthfully as possible, and if you're unsure of the answer, say "Sorry, I don't know".

Q: Which clothing brands did the 2015 Australian Fashion Report expose for ongoing exploitation of overseas workers?
A:"""

openai.Completion.create(
    prompt=prompt,
    temperature=0,
    max_tokens=300,
    top_p=1,
    frequency_penalty=0,
    presence_penalty=0,
    engine="text-davinci-002"
)["choices"][0]["text"].strip(" \n")
```

This outputs: "Sorry, I don't know."

We can help the model answer correctly by providing contextual information into the prompt. When the required context is short, we can fit it into the prompt within the token limitation.

Let's update the prompt with the contextual information and explicitly tell the model to refer to the provided text when answering the question.

```python
prompt = """Answer the question as truthfully as possible using the provided text, and if the answer is not contained within the text below, say "I don't know"

Context:
As Australian Fashion Week comes to a close, a new damning report has named and shamed some of the worst clothing brands sold in Australia and their companies, for the ongoing exploitation of their overseas workers. Lowes, Industrie, Best & Less and the Just Group - which includes Just Jeans, Portmans and Dotti - were identified as some of the worst performing companies by The 2015 Australian Fashion Report. Amongst the best performers were Etiko, Audrey Blue, Cotton On, H&M and Zara. The report assessed the labour rights management systems of 59 companies and 219 brands operating in Australia. The 2015 Australian Fashion Report has named and shamed some of the worst Aussie clothing brands and companies for their ongoing exploitation of overseas workers . Amongst the best performers were Etiko, Audrey Blue, Cotton On, H&M and Zara . It found that only two of the companies could prove they were paying a full living wage to the workers in two of the three production stages of their clothing. None of the 59 companies could prove the workers at their raw material suppliers were paid a living wage. Unlike a country's legally set minimum wage, a living wage ensures that an employee has enough money to cover the necessities - like food, water, electricity and shelter - and still has a little left over for themselves and their dependants. In some countries like Bangladesh, where the minimum wage is as little as US$68 a month and a living wage is US$104, the difference can be made by paying each worker just an additional 30c per t-shirt

Q: Which clothing brands did the 2015 Australian Fashion Report expose for ongoing exploitation of overseas workers?
A:"""

openai.Completion.create(
    prompt=prompt,
    temperature=0,
    max_tokens=300,
    top_p=1,
    frequency_penalty=0,
    presence_penalty=0,
    engine="text-davinci-002"
)["choices"][0]["text"].strip(" \n")
```

This outputs: 'Lowes, Industrie, Best & Less, and the Just Group - which includes Just Jeans, Portmans, and Dotti - were identified as some of the worst performing companies by The 2015 Australian Fashion Report.'

As we can see, this approach of adding extra information into the prompt works well. However, we are limited by ensure the contextual information is small enough to fit within the token limiation.

This brings up, how do we know what information to choose to put into the prompt when we have a large body of information when you can't fit it all in?

The remainder of this section will go over how to use embeddings to selectively choose the most relevant context out of a large body of text, that will be used to augment a few shot prompt. This method answers the initial question in 2 steps:

1. Retrieving the information relevant to the query using the **Embeddings API**.
2. Appending teh relevant context to the few shot prompt using the **Completions API**.

Let's dive into an end to end example to see how this works.

### Example 

We will use the CNN/Daily Mail dataset once again for this example.

The steps that we will execute this approach are as follows:

1. Preprocess the knowledge base by splitting into chunk and creating an embedding vector for each chunk
2. On receiving a query, embed the query in the same vector space as the context chunks from Step 1. 
3. Find the most context chunks that are most similar to the query.
4. Append the most relevant context chunk to the few shot prompt, and submit the question to GPT-3 with the Completion endpoint.

#### Step 1: Preprocess the knowledge base and create context chunks embeddings
```python
df = pd.read_csv("\data\cnn_dailymail_data.csv")
df = df[["article", "highlights"]]
df = df.head(50) #for the sake of the example, we will only take the first 50 articles as our knowledge base to reduce compute time
```

In the next few code blocks, we will take the individual articles are break them into chunks by isolating 10 sentences as a time. Then we will embed those individual chunks. 

This will result in context chunks and their corresponding vector embedding.

```python
# Segmenting document by chunking for every 10 sentences
# Resulting dataframe will have the og_row or the original index from the knowledge base, so we can refer back to the full article text if needed

df_cols = ["og_row", "chunk"]
df_chunked = pd.DataFrame(columns=df_cols)
for idx, row in df.iterrows():
    df_temp = pd.DataFrame(columns=df_cols)
    for elem in splitter(10,row["article"]):
        df_temp.loc[len(df_temp.index)] = [idx, elem]
    df_chunked = df_chunked.append(df_temp)

df_chunked.reset_index(drop=True, inplace=True)
```

```python
df_chunked['curie_search'] = df_chunked['chunk'].apply(lambda x : get_embedding(x, engine = 'text-search-curie-doc-001'))
```

#### Step 2: On receiving a query, embed the query in the same vector space as the context chunks

```python
input_query = "Which clothing brands did the 2015 Australian Fashion Report expose for ongoing exploitation of overseas workers?"
```

We will take the input query and embed it in the same vector space as the context chunks. We will use the corresponding query model ("text-search-query-curie-001")

#### Step 3: Find the most context chunks that are most similar to the query.

The code sample below combines step 2 and step 3. We will embed te input query and then find the top 3 context chunks that are most similar to the input query.

```python
# search through the document for a text segment most similar to the query
# display top two most similar chunks based on cosine similarity
def search_docs(df, user_query, n=3, pprint=True):
    embedding = get_embedding(
        user_query,
        engine="text-search-curie-query-001"
    )
    print(len(embedding))
    df["similarities"] = df.curie_search.apply(lambda x: cosine_similarity(x, embedding))

    res = (
        df.sort_values("similarities", ascending=False)
        .head(n)
    )
    if pprint:
        display(res)
    return res


res = search_docs(df_chunked, input_query, n=3)
```

Let's take a look at the resulting top context chunks that were found through embeddings:

> Simialrity score: 0.49
> > As Australian Fashion Week comes to a close, a new damning report has named and shamed some of the worst clothing brands sold in Australia and their companies, for the ongoing exploitation of their overseas workers Lowes, Industrie, Best & Less and the Just Group - which includes Just Jeans, Portmans and Dotti - were identified as some of the worst performing companies by The 2015 Australian Fashion Report Amongst the best performers were Etiko, Audrey Blue, Cotton On, H&M and Zara The report assessed the labour rights management systems of 59 companies and 219 brands operating in Australia The 2015 Australian Fashion Report has named and shamed some of the worst Aussie clothing brands and companies for their ongoing exploitation of overseas workers  Amongst the best performers were Etiko, Audrey Blue, Cotton On, H&M and Zara  It found that only two of the companies could prove they were paying a full living wage to the workers in two of the three production stages of their clothing None of the 59 companies could prove the workers at their raw material suppliers were paid a living wage Unlike a country's legally set minimum wage, a living wage ensures that an employee has enough money to cover the necessities - like food, water, electricity and shelter - and still has a little left over for themselves and their dependants In some countries like Bangladesh, where the minimum wage is as little as US$68 a month and a living wage is US$104, the difference can be made by paying each worker just an additional 30c per t-shirt 

> Simialrity score: 0.43
> > Lowes, Industrie, Best & Less and the Just Group - which includes Just Jeans, Portmans and Dotti - were identified as some of the worst performers  'The whole point in our reporting scorecard is if these companies don't have rigours systems in place to mitigate against those risks then you can't be sure that there is no forced labour or child labour in their supply chain,' Gershon Nimbalker, an advocacy manager at Baptist World Aid, said  'A mere 12 per cent of companies could demonstrate any action towards paying wages above the legal minimum, and even then, only for part of their supply chain,' the report states 'Furthermore, 91 per cent of companies still don't know where all their cotton comes from and 75 per cent don't know the source of all their fabrics and inputs 'If companies don't know how and where their products are made, then there's no way for them to ensure that their workers are protected.' Uzbekistan for instance, the world's fifth largest exporter of cotton, was notorious for its  child labour policies which saw children as young as 10 forced to work in the fields until the government recently  improved conditions by renouncing the use of child labour 'on a systematic basis' 'Furthermore, 91 per cent of companies still don't know where all their cotton comes from and 75 per cent don't know the source of all their fabrics and inputs,' the report stated  Gershon Nimbalker, an advocacy manager at Baptist World Aid told Daily Mail Australia that part of the motivation behind the report was to shed light on how many of the world's 165 million children involved in child labour were employed by the fashion industry 'The whole point in our reporting scorecard is if these companies don't have rigours systems in place to mitigate against those risks then you can't be sure that there is no forced labour or child labour in their supply chain,' he said 'There were 61 assessment criteria that we used to grade the companies that were put together with lots of collaboration with international labour rights organisations 'We found all the public information available on the companies - public statements, anything online - and compiled and assessed it before sending a copy to the company and asking for feedback or asking them to tell us what we missed 

> Similarity score: 0.43
> > The report comes almost two years after over 1,100 Bangladeshi garment workers died when the Rana Plaza factory collapsed in Bangladesh due to building safety problems  'We found all the public information available on the companies - public statements, anything online - and compiled and assessed it before sending a copy to the company and asking for feedback or asking them to tell us what we missed 'The worst grades basically mean that they have very little public information available about what they're doing to protect workers and on top of that that they haven't engaged with our research process About 75 per cent did engage, but one quarter didn't.' However the report also noted some progress in the industry with companies like Kmart and Cotton On improving their transparency by identifying their suppliers, and H&M, Zara, Country Road and the Sussan Group showing attempts to improve their international worker's pay.

As we can see, the emebddings API found the most relevant chunks that we can use to enhance our prompt engineering efforts.

#### Step 4: Append the most relevant context chunk to the few shot prompt, and submit the question to GPT-3 with the Completion endpoint.

```python
context_chunk = res.iloc[0,1] #selecting top content chunk
```

```python
#Designing the prompt to avoid hallucinations, inject the context chunk found using embeddings, and answer the input_query

prompt = """Answer the question as truthfully as possible using the provided text, and if the answer is not contained within the text below, say "I don't know"

Context:\n""" + context_chunk + """

Q: """ + input_query + """ 
A:"""

openai.Completion.create(
    prompt=prompt,
    temperature=0,
    max_tokens=300,
    top_p=1,
    frequency_penalty=0,
    presence_penalty=0,
    engine="text-davinci-002"
)["choices"][0]["text"].strip(" \n")
```

The output is: 'Lowes, Industrie, Best & Less, and the Just Group - which includes Just Jeans, Portmans, and Dotti.'

As a result, by combining Embeddings and Completion APIs we can create powerful question answering few shot models that can answer questions on a large knowledge base without needing to finetune. It also understand to answer truthfully and not hallucinate when the answer isn't clear. 

## Takeaways

Overall, embeddings are an extremely useful model for many different use
cases such as text search and text similarity.

We find that embeddings are extremely performant for document search and
ranking given a query. Additionally, embeddings can aid in pinpointing a
specific region in a long document that can answer a user query specific
to the document.

## Appendix

Original text from CNN/Daily Mail Dataset:

> As Australian Fashion Week comes to a close, a new damning report has named and shamed some of the worst clothing brands sold in Australia and their companies, for the ongoing exploitation of their overseas workers. Lowes, Industrie, Best & Less and the Just Group - which includes Just Jeans, Portmans and Dotti - were identified as some of the worst performing companies by The 2015 Australian Fashion Report. Amongst the best performers were Etiko, Audrey Blue, Cotton On, H&M and Zara. The report assessed the labour rights management systems of 59 companies and 219 brands operating in Australia. The 2015 Australian Fashion Report has named and shamed some of the worst Aussie clothing brands and companies for their ongoing exploitation of overseas workers . Amongst the best performers were Etiko, Audrey Blue, Cotton On, H&M and Zara . It found that only two of the companies could prove they were paying a full living wage to the workers in two of the three production stages of their clothing. None of the 59 companies could prove the workers at their raw material suppliers were paid a living wage. Unlike a country's legally set minimum wage, a living wage ensures that an employee has enough money to cover the necessities - like food, water, electricity and shelter - and still has a little left over for themselves and their dependants. In some countries like Bangladesh, where the minimum wage is as little as US$68 a month and a living wage is US$104, the difference can be made by paying each worker just an additional 30c per t-shirt. Lowes, Industrie, Best & Less and the Just Group - which includes Just Jeans, Portmans and Dotti - were identified as some of the worst performers . 'The whole point in our reporting scorecard is if these companies don't have rigours systems in place to mitigate against those risks then you can't be sure that there is no forced labour or child labour in their supply chain,' Gershon Nimbalker, an advocacy manager at Baptist World Aid, said . 'A mere 12 per cent of companies could demonstrate any action towards paying wages above the legal minimum, and even then, only for part of their supply chain,' the report states. 'Furthermore, 91 per cent of companies still don't know where all their cotton comes from and 75 per cent don't know the source of all their fabrics and inputs. 'If companies don't know how and where their products are made, then there's no way for them to ensure that their workers are protected.' Uzbekistan for instance, the world's fifth largest exporter of cotton, was notorious for its  child labour policies which saw children as young as 10 forced to work in the fields until the government recently  improved conditions by renouncing the use of child labour 'on a systematic basis'. 'Furthermore, 91 per cent of companies still don't know where all their cotton comes from and 75 per cent don't know the source of all their fabrics and inputs,' the report stated . Gershon Nimbalker, an advocacy manager at Baptist World Aid told Daily Mail Australia that part of the motivation behind the report was to shed light on how many of the world's 165 million children involved in child labour were employed by the fashion industry. 'The whole point in our reporting scorecard is if these companies don't have rigours systems in place to mitigate against those risks then you can't be sure that there is no forced labour or child labour in their supply chain,' he said. 'There were 61 assessment criteria that we used to grade the companies that were put together with lots of collaboration with international labour rights organisations. 'We found all the public information available on the companies - public statements, anything online - and compiled and assessed it before sending a copy to the company and asking for feedback or asking them to tell us what we missed. The report comes almost two years after over 1,100 Bangladeshi garment workers died when the Rana Plaza factory collapsed in Bangladesh due to building safety problems . 'We found all the public information available on the companies - public statements, anything online - and compiled and assessed it before sending a copy to the company and asking for feedback or asking them to tell us what we missed. 'The worst grades basically mean that they have very little public information available about what they're doing to protect workers and on top of that that they haven't engaged with our research process. About 75 per cent did engage, but one quarter didn't.' However the report also noted some progress in the industry with companies like Kmart and Cotton On improving their transparency by identifying their suppliers, and H&M, Zara, Country Road and the Sussan Group showing attempts to improve their international worker's pay.
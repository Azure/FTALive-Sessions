# Query Based Summarization 

## Introduction

Knowledge bases in enterprises are very common in the industry today and
can have extensive number of documents in different categories.
Retrieving relevant content based on a user query is a challenging task.
Given a query we were able to retrieve information accurately at the
document level using methods such as Page Rank developed and made highly
accurate especially by Google, after this point the user must delve into
the document and search for the relevant information. With recent
advances in Foundation Transformer Models such as the one developed by
Open AI the challenge is alleviated by using "Semantic Search" methods
by using encoding information such as "Embeddings" to find the relevant
information and then to summarize the content to present to the user in
a concise and succinct manner.

This Playbook will introduce the Use Case and End to End architecture
briefly and for the most part will take you through the step-by-step
process of using OpenAI\'s GPT-3 model to perform long text
summarization, walking through using a what is referred to as
"zero-shot" examples, "few-shot" prompt engineering examples, and
finetuning methods to change and improve the output summaries. There are
different pros and cons to each approach such as performance, cost, and
training time.

This playbook aims to demonstrate how to use Azure OpenAI's GPT-3
capabilities to adapt to your summarization case, and how to set up and
evaluate summarization results. The methods and architecture are
extremely customizable to your summarization use case and can be applied
to many different datasets.

## Use Case

Text summarization is the process of creating summaries from large
volumes of data while maintaining significant informational elements and
content value. A few reasons why text summarization is essential across
industries are:

1.  Shortens reading time
2.  Improves the effectiveness of searching for information among vast
    quantities of data and also the sheer volume of disparate data
3.  Reduces bias from human summarization techniques
4.  Frees up bandwidth for humans to focus on more in-depth analysis

The need for document summarization be applied to any business domain
(legal, financial, reporting/news, medical, academic, etc) that requires
long document summarization. The subject matter that this playbook is
focusing on is legal - we will use a corpus of US bills passed through
Congress. As the subject gets more technical, we make a case for further
fine-tuning of the GPT3-model rather than just using the few-shot or
zero-shot example methods. Supplementary to this document is a jupyter
notebook with the technical details and execution of this use case.

##  End to End Architecture

![Figure 1: Technical article search and summarization using GPT-3
endpoints](images/EndtoEndArchitectureSummarizerOnly.png)
<figcaption align = "center"><b>Figure 1: Technical article search and summarization using GPT-3
endpoints</b></figcaption>

An E2E architecture shown in Figure 1 captures the Use case that we
talked about in the previous sections. The User Query is first
conditioned through a Intention Recognizer such as LUIS and the output
of this is used to act as an input to the Elastic Search block which
filters out the number of documents to be in the hundreds instead of
thousands or tens of thousands. The User Query is used again on Search
Endpoint such as Cognitive Services Search Endpoint to zone in one
article or document from an existing knowledge base populated offline
(based on the Page Ranking). Once the article or document is \"zoned-in
on\". The relevant sentences are all \"Extracted\" using either a coarse
method such as extracting all sentences that contain the User Query or
by using a more sophisticated method such as GPT-3 based embeddings to
find the semantically similarly material in the document. Once the
relevant pieces are \"Extracted\" then the GPT-3 Completion point with
Summarization conditioning is used to Summarize the material.

**This document will be exclusively focusing on the "Summarizer" component
of the architecture.**

## Summarizer

This section will cover the end-to-end flow of using the GPT-3 models
for summarization tasks. We will look at how to craft the prompts for
zero-shot and few-shots examples, walk through fine tuning a model, and
compare results from these different approaches.

The model used by the Azure OpenAI service is a generative completion
call which uses natural language instructions to identify the task being
asked and skill required -- aka Prompt Engineering. Using this approach,
the first part of the prompt includes natural language instructions
and/or examples of the specific task desired. The model then completes
the task by predicting the most probable next text. This technique is
known as \"in-context\" learning. 

There are three main approaches for in-context learning: Zero-shot,
Few-shot and Fine tuning. These approaches vary based on the amount of
task-specific data that is given to the model: 

**Zero-shot**: In this case, no examples are provided to the model and
only the task request is provided. 

**Few-shot**: In this case, a user includes several examples in the call
prompt that demonstrate the expected answer format and content. 

**Fine-Tuning**: Fine Tuning lets you tailor models to your personal
datasets. This customization step will let you get more out of the
service by providing: 

-   With lots of data (at least 500 and above) traditional optimization
    techniques are used with Back Propagation to re-adjust the weights
    of the model -- this enables higher quality results than mere
    zero-shot or few-shot. 

-   A customized model improves the few-shot learning approach by
    training the model weights on your specific prompts and structure.
    This lets you achieve better results on a wider number of tasks
    without needing to provide examples in the prompt. The result is
    less text sent and fewer tokens 

### Dataset

The first dataset we will look at is the BillSum dataset. BillSum is the
first dataset for summarization of US Congressional and California state
bills. For illustration purposes, we will look at the US bills solely.
The corpus consists of bills from the 103rd-115th (1993-2018) sessions
of Congress. The data was split into 18,949 train bills and 3,269 test
bills.  The BillSum corpus focuses on mid-length legislation from 5,000
to 20,000 characters in length. It has already been
cleaned/preprocessed.

More information on the dataset and downloading instructions can be
found [here](https://github.com/FiscalNote/BillSum):

#### US Congressional Bills

This section uses the BillSum dataset.

The schema of the dataset includes:

-   bill_id: an identifier for the bill
-   text: US bill text
-   summary: human written bill summary
-   title: bill title
-   text_len: character length of the bill
-   sum_len: character length of the bill summary

In our use case we will use the text and summary components.

### Prompt Engineering

We will be using the **Completion endpoint** for summarization. You
input some text as a prompt, and the model will generate a text
completion that attempts to match whatever context or pattern you gave
it.

More information on the completion endpoint can be found here:

[OpenAI/Completions.md at main · Azure/OpenAI
(github.com)](https://github.com/Azure/OpenAI/blob/main/How%20to/Completions.md)

#### Prompt Design

GPT-3 models can perform many tasks. Therefore, one must be explicit in
describing what you want.

The models try to guess what you want from the prompt. If one sends the
words \"Give me a list of cat breeds,\" the model wouldn\'t
automatically assume that you\'re asking for a list of cat breeds. You
could just as easily be asking the model to continue a conversation
where the first words are \"Give me a list of cat breeds\" and the next
ones are \"and I\'ll tell you which ones I like.\" If the model only
assumed that you wanted a list of cats, it wouldn\'t be as good at
content creation, classification, or other tasks.

There are three basic guidelines to creating prompts:

**Show and tell**. Make it clear what you want either through
instructions, examples, or a combination of the two. If you want the
model to rank a list of items in alphabetical order or to classify a
paragraph by sentiment, show it that\'s what you want.

**Provide quality data**. If you\'re trying to build a classifier or get
the model to follow a pattern, make sure that there are enough examples.
Be sure to proofread your examples --- the model is usually smart enough
to see through basic spelling mistakes and give you a response, but it
also might assume this is intentional and it can affect the response.

**Check your settings.** The temperature and top_p settings control how
deterministic the model is in generating a response. If you\'re asking
it for a response where there\'s only one right answer, then you\'d want
to set these lower. If you\'re looking for more diverse responses, then
you might want to set them higher. The number one mistake people use
with these settings is assuming that they\'re \"cleverness\" or
\"creativity\" controls.

Source:
<https://github.com/Azure/OpenAI/blob/main/How%20to/Completions.md>

#### News Use Case

This section will walk through zero shot prompt engineering for the
legal use case. We will look at sample US bills and modify the prompt
and settings to see different summary outputs.

##### Zero Shot

The goal of this is to teach the GPT-3 model to learn conversation style
input. We use the "Completion" to create OpenAI API and generate a
prompt that would best provide us a summary of the conversation. It is
important to generate prompts carefully to extract relevant information.
To extract general summaries from customer-agent chats, we will be using
the following format:

1.  Prefix: What do you want it to do
2.  Context primer: Describe what the context is
3.  Context: \# Essentially the information needed to answer the
    question. In the case of summary, the prose that needs to be
    summarized.
4.  Suffix: Describe what form the answer should take. Whether it is an
    answer, a completion, a summary, etc


```python
API_KEY = # SET YOUR OWN API KEY HERE
RESOURCE_ENDPOINT = " -- # SET A LINK TO YOUR RESOURCE ENDPOINT -- " 

openai.api_type = "azure"
openai.api_key = API_KEY
openai.api_base = RESOURCE_ENDPOINT
openai.api_version = " -- insert API version -- "
```

```python
prompt_i = 'Summarize the legislative bill given the title and the text.\n\nTitle:\n'+" ".join([normalize_text(bill_title_1)])+ '\n\nText:\n'+ " ".join([normalize_text(bill_text_1)])+'\n\nSummary:\n'
response = openai.Completion.create(
    engine= TEXT_DAVINCI_001
    prompt = prompt_i,
    temperature = 0.4,
    max_tokens = 500,
    top_p = 1.0,
    frequency_penalty=0.5,
    presence_penalty = 0.5,
    stop=['\n\n###\n\n'], #the ending token used during inference, once reaches this token GPT-3 knows the completion is over
    best_of = 1
    )
 = 1
 ```

**Original text:** Refer to [SAMPLE_BILL_1](#sample_bill_1) in appendix.

**Ground truth:** National Science Education Tax Incentive for
Businesses Act of 2007 - Amends the Internal Revenue Code to allow a
general business tax credit for contributions of property or services to
elementary and secondary schools and for teacher training to promote
instruction in science, technology, engineering, or mathematics.

**Zero-shot model summary:** The National Science Education Tax
Incentive for Businesses Act of 2007 would create a new tax credit for
businesses that make contributions to science, technology, engineering,
and mathematics (STEM) education at the elementary and secondary school
level. The credit would be equal to 100 percent of the qualified STEM
contributions of the taxpayer for the taxable year. Qualified STEM
contributions would include STEM school contributions, STEM teacher
externship expenses, and STEM teacher training expenses.

##### Zero Shot Observations

Overall, zero-shot does an excellent job at providing a succinct summary
of the legal document that is general in nature. It is very similar to
the human written ground truth and captures those same key points. It
flows like a human conversation and stays direct to the point

Finetuning

Learn how to customize a model for your application, by changing the
model weights to customize to your use case.

Fine-tuning lets you get more out of the models available through the
API by providing:

-   Higher quality results than prompt design
-   Ability to train on more examples than can fit in a prompt
-   Token savings due to shorter prompts
-   Lower latency requests

Fine-tuning improves on few-shot learning by training on many more
examples than can fit in the prompt, letting you achieve better results
on a wide number of tasks. Once a model has been fine-tuned, you won\'t
need to provide examples in the prompt anymore. This saves costs and
enables lower-latency requests.

At a high level, fine-tuning involves the following steps:

-   Prepare and upload training data
-   Train a new fine-tuned model
-   Use your fine-tuned model

*Note, we will be finetuning the news dataset only. Not enough data
provided for financial reports finetune.*

###### source: <https://beta.openai.com/docs/guides/fine-tuning>

##### Preparing data for finetuning

This function allows us to leverage the power of the zero-shot model by
injecting prompt engineering into the prompts used for finetuning. This
helps give directions to the model on how to approach the
prompt/completion pairs.

```python
#adding variables used to design prompt consistently across all examples
#more info can be found here: https://learn.microsoft.com/en-us/azure/cognitive-services/openai/how-to/prepare-dataset

LINE_SEP = " \n "
PROMPT_END = " [end] "
```

```python
#Injecting the zero shot prompt into finetune dataset
def stage_examples(proc_df):
    proc_df['prompt'] = proc_df.apply(lambda x:"Summarize the legislative bill. Do not make up facts.\n\nText:\n"+" ".join([normalize_text(x['prompt'])])+'\n\nSummary:', axis=1)
    proc_df['completion'] = proc_df.apply(lambda x:" "+normalize_text(x['completion'])+PROMPT_END, axis=1)
    
    return proc_df

df_staged_full_train = stage_examples(df_prompt_completion_train)
df_staged_full_val = stage_examples(df_prompt_completion_val)
```

Now that the data is staged for finetuning in the proper format, we can
start running the finetune commands.

Next, we use OpenAI\'s command-line interface (CLI) to assist with many
of the data preparation steps. OpenAI has developed a tool which
validates, gives suggestions, and reformats your data. This step is
currently not in the notebook and needs to be done manually in the
command line 

```python
pip install --upgrade openai  
openai tools fine_tunes.prepare_data -f <LOCAL_FILE> 

```

At the end of this step, we should have three JSONL files :
test_prepared.jsonl, train_prepared.jsonl, validate_prepared.jsonl 

```python
# Run the commands below to prepare the data sets for finetuning

'''
>>> C:/OpenAI/venv/Scripts/openai tools fine_tunes.prepare_data -f C:/data/billsum_v4_1/prompt_completion_staged_train.csv

>>> C:/OpenAI/venv/Scripts/openai tools fine_tunes.prepare_data -f C:/data/billsum_v4_1/prompt_completion_staged_val.csv

'''
```

##### *Finetune news dataset*
```python
payload = {
  "model": "curie",
  "training_file": " -- INSERT TRAINING FILE ID -- ",
  "validation_file": "-- INSERT VALIDATION FILE ID --",
  "hyperparams": {
    "n_epochs": 1,
    "batch_size": 200,
    "learning_rate_multiplier": 0.1,
    "prompt_loss_weight": 0.0001
    
  }
}

url = RESOURCE_ENDPOINT + "openai/fine-tunes?api-version=2022-03-01-preview"
r = requests.post(url, 
    headers={
    "api-key": API_KEY,
    "Content-Type": "application/json"
    },
    json = payload
)

data = r.json()
print(data)
fine_tune_id = data['id']
print('Endpoint Called: {endpoint}'.format(endpoint = url))
print('Status Code: {status}'.format(status= r.status_code))
print('Fine tuning job ID: {id}'.format(id=fine_tune_id))
print('Response Information \n\n {text}'.format(text=r.text))
```

#### Evaluation of fine-tuned model

This section will demonstrate how to evaluate a fine tuned model.

```python
#Run this cell to check status
url = RESOURCE_ENDPOINT + "openai/fine-tunes/<--insert finetune id-->?api-version=2022-03-01-preview"
r = requests.get(url, 
    headers={
    "api-key": API_KEY,
    "Content-Type": "application/json"
    }
)

data = r.json()
print('Endpoint Called: {endpoint}'.format(endpoint = url))
print('Status Code: {status}'.format(status= r.status_code))
print('Fine tuning ID: {id}'.format(id=fine_tune_id))
print('Status: {status}'.format(status = data['status']))
print('Response Information \n\n {text}'.format(text=r.text))
```

**Original text:** Refer to [SAMPLE_BILL_1](#sample_bill_1) in appendix.

**Ground truth:** National Science Education Tax Incentive for
Businesses Act of 2007 - Amends the Internal Revenue Code to allow a
general business tax credit for contributions of property or services to
elementary and secondary schools and for teacher training to promote
instruction in science, technology, engineering, or mathematics.

**Fine-tune model summary:** This bill provides a tax credit for
contributions to elementary and secondary schools that benefit science,
technology, engineering, and mathematics education. The credit is equal
to 100% of qualified STEM contributions made by taxpayers during the
taxable year. Qualified STEM contributions include: (1) STEM school
contributions, (2) STEM teacher externship expenses, and (3) STEM
teacher training expenses. The bill also provides a tax credit for
contributions to elementary and secondary schools that benefit science,
technology, engineering, or mathematics education. The credit is equal
to 100% of qualified STEM service contributions made by taxpayers during
the taxable year. Qualified STEM service contributions include: (1) STEM
service contributions paid or incurred during the taxable year for
services provided in the United States or on a military base outside the
United States; and (2) STEM inventory property contributed during the
taxable year which is used by an educational organization located in the
United States or on a military base outside the United States in
providing education in grades K-12 in science, technology, engineering
or mathematics.

##### Finetune Observations

Overall, the finetuned model does an excellent job in summarizing the
bill. It captures the domain specific jargon and can capture the key
points represented in the human written ground truth. It differentiates
itself from the zero-shot model by providing more details for a more
detailed and comprehensive summary.

## Results for BillSum Dataset

Here is a subset of results highlighting different performance for each
approach taken. Original bill texts can be found in the Appendix
section.

Note, due to the token constraint limit of 2048 for the prompts we were
unable to perform few-shot learning with documents.

| Original Text        | Ground Truth | Zero Shot |Fine Tune|
|----------------------|--------------|-----------|---------|
| SAMPLE_BILL_1* |National Science Education Tax Incentive for Businesses Act of 2007 - Amends the Internal Revenue Code to allow a general business tax credit for contributions of property or services to elementary and secondary schools and for teacher training to promote instruction in science, technology, engineering, or mathematics. | The National Science Education Tax Incentive for Businesses Act of 2007 would create a new tax credit for businesses that make contributions to science, technology, engineering, and mathematics (STEM) education at the elementary and secondary school level. The credit would be equal to 100 percent of the qualified STEM contributions of the taxpayer for the taxable year. Qualified STEM contributions would include STEM school contributions, STEM teacher externship expenses, and STEM teacher training expenses. | This bill provides a tax credit for contributions to elementary and secondary schools that benefit science, technology, engineering, and mathematics education. The credit is equal to 100% of qualified STEM contributions made by taxpayers during the taxable year. Qualified STEM contributions include: (1) STEM school contributions, (2) STEM teacher externship expenses, and (3) STEM teacher training expenses. The bill also provides a tax credit for contributions to elementary and secondary schools that benefit science, technology, engineering, or mathematics education. The credit is equal to 100% of qualified STEM service contributions made by taxpayers during the taxable year. Qualified STEM service contributions include: (1) STEM service contributions paid or incurred during the taxable year for services provided in the United States or on a military base outside the United States; and (2) STEM inventory property contributed during the taxable year which is used by an educational organization located in the United States or on a military base outside the United States in providing education in grades K-12 in science, technology, engineering or mathematics.|
| SAMPLE_BILL_2* | Small Business Expansion and Hiring Act of 2011 - Amends the Internal Revenue Code to allow nongovernmental employers who employ an average of fewer than 100 employees during a taxable year a retained worker tax credit until December 31, 2012, for the lesser of $4,000 or 6.2 of the wages paid to a retained worker during a period of not less than 52 consecutive weeks of employment. Limits the amount of such credit with respect to any business location of the employer to $400,000 and provides that the number of retained workers taken into account for such credit shall not exceed the excess of the number of employees of the taxpayer at the end of the taxable year over the number of such employees at the beginning of the taxable year. Defines retained worker to mean any qualified individual who was employed on any date during the taxable year for a period of not less than 52 weeks and whose wages during the last 26 weeks of such period equaled at least 80 of such wages for the first 26 weeks of such period. Defines qualified individual as any individual who: (1) begins employment after 2010 and before 2014, (2) certifies by signed affidavit that such individual has not been employed for 40 hours or more per week during the 60-day period ending on the date such individual begins employment, (3) is not replacing another employee, and (4) is not disqualified for such credit by a relationship to the employer. | The Small Business Expansion and Hiring Act of 2011 would create a new tax credit for employers who retain certain workers newly hired before 2013. The credit would be equal to $4,000 ($6,000 in the case of a long-term unemployed individual) or 6.2 percent of the wages paid to the retained worker during the 52 consecutive week period referred to in subsection (c)(2). The credit would be allowed as a business credit under section 38(b) of the Internal Revenue Code of 1986 and would be subject to a limitation based on the number of employees and the amount paid to retained workers. | This bill amends the Internal Revenue Code to allow a taxpayer to claim a business credit for hiring certain individuals who have been unemployed for at least 26 weeks. The credit is equal to 6.2 percent of the wages paid to such individuals during their last 26 weeks of employment. A taxpayer may not claim more than $400,000 in credits per year under this provision. The bill also allows taxpayers to carry forward unused credits for 3 years and permits taxpayers to claim a business credit equal to 3 percent of wages paid during the first 60 days after an individual begins work with an employer who is not a qualified employer |
| SAMPLE_BILL_3* |  Requires the Director of National Intelligence to make publicly available on an Internet website all documents captured in Afghanistan or Iraq during Operations Desert Storm, Enduring Freedom, or Iraqi Freedom. Provides conditions under which the Director shall not be required to make a captured document publicly available, including providing a list of retained documents, and the criteria used for such retention, to the congressional intelligence committees. | The bill would require the Director of National Intelligence to make publicly available on an Internet website all captured documents. The Director would be allowed to review a captured document before making it publicly available, and may not make a captured document publicly available if it meets certain criteria. The Director would also be required to submit reports to Congress regarding any captured documents that are not made publicly available.| This bill requires the Director of National Intelligence to make publicly available on an Internet website all captured documents. It also requires the Director to review a captured document before making it publicly available. The Director may not make a captured document publicly available if: (1) in the case of a captured document that is reviewed by the Director before the date of enactment, the Director submits to relevant congressional committees a description of criteria used to determine it is not appropriate to make it publicly available and such captured document meets such criteria; or (2) in the case of a captured document that is reviewed by the Director on or after such date, the Director submits to relevant congressional committees a description of criteria used to determine if it is not appropriate to make it publicly available and such captured document meets such criteria.|
| SAMPLE_BILL_4* |Military Call-up Relief Act - Amends the Internal Revenue Code to waive the ten percent early withdrawal penalty for distributions from qualified retirement plans to individuals called to active duty during the national emergency declared by the President on September 14, 2001.|The Military Call-Up Relief Act allows individuals called to active duty during the national emergency declared by the President on September 14, 2001, to waive the 10-percent additional tax on early distributions from qualified retirement plans. The Act also allows catch-up contributions for these individuals.| This bill provides for a waiver of the 10% additional tax on early distributions from qualified retirement plans for individuals called to active duty in the National Emergency declared by the President on September 14, 2001.| 
| SAMPLE_BILL_5* |Service Dogs for Veterans Act of 2009 - Directs the Secretary of Veterans Affairs (VA) to commence a three-year pilot program to assess the benefits, feasibility, and advisability of using service dogs for the treatment or rehabilitation of veterans with physical or mental injuries or disabilities, including post-traumatic stress disorder. Requires related reports to Congress.|The Service Dogs for Veterans Act of 2009 is a bill that would establish a pilot program to study the benefits of using service dogs for the treatment or rehabilitation of veterans with physical or mental injuries or disabilities. The program would be run by the Department of Veterans Affairs in partnership with nonprofit organizations that provide service dogs free of charge to individuals with injuries or disabilities. The Secretary of Veterans Affairs would be required to provide a service dog to a number of veterans with physical or mental injuries or disabilities, and the National Academy of Sciences would be required to submit a report on the results of the pilot program.|This bill requires the Secretary of Veterans Affairs to carry out a three-year pilot program to assess the benefits, feasibility, and advisability of using service dogs for the treatment or rehabilitation of veterans with physical or mental injuries or disabilities. The bill requires the Secretary to partner with nonprofit organizations that: (1) have experience providing service dogs to individuals with injuries or disabilities; (2) do not charge fees for the dogs, services, or lodging that they provide; and (3) are accredited by a generally accepted industry-standard accrediting institution. The bill requires reimbursement of costs relating to the pilot program as follows: (1) For the first 50 dogs provided under the pilot program, all costs relating to the provision of such dogs. (2) For dogs provided under the pilot program after the first 50 dogs provided, all costs relating to the provision of every other dog. |


Refer to appendix section for sample bill text.

## Zero-Shot Summary of Summaries 

Due to the token limit constraint, we are limited to a couple of pages
of text (2048 tokens) for summarization and therefore for documents
which are typically greater than this we will use a Summary of Summaries
approach, wherein the entire text is first chunked up based on the
constraints, the corresponding summaries are derived and then in the
next step the summary of summaries are created. This section will
demonstrate the summary of summaries approach using a zero-shot model.
This architecture is useful for long documents. Additionally, it will
highlight how different prompt engineering practices can vary the
results.

### Dataset

The dataset used for this approach will be a financial dataset. This
dataset is technical and includes many key quantitative metrics to
assess company performance.

The financial dataset includes:

-   url: URL for the financial report
-   pages: The page in the report with key information to be summarized
    (1 - indexed)
-   completion: ground truth summary of report
-   comments: any additional information needed

The example from the dataset we will focus on is Rathbone's financial
[report](https://www.rathbones.com/sites/rathbones.com/files/imce/rathbones_2020_preliminary_results_announcement_-_final-.pdf).
Rathbone's is an individual investment and wealth management company for
private clients. This report highlights Rathbone's performance in the
2020 calendar year, and mentions performance metrics such as profit,
FUMA, and income. The key information we aim to summarize is found on
page 1 of the PDF.

```python
API_KEY = # SET YOUR OWN API KEY HERE
RESOURCE_ENDPOINT = "# SET A LINK TO YOUR RESOURCE ENDPOINT" 

openai.api_type = "azure"
openai.api_key = API_KEY
openai.api_base = RESOURCE_ENDPOINT
openai.api_version = "2022-03-01-preview"
```

```python
name = os.path.abspath(os.path.join(os.getcwd(), '---INSERT PATH OF LOCALLY DOWNLOADED RATHBONES_2020_PRELIM_RESULTS---')).replace('\\', '/')

pages_to_summarize = [0]
```

```python
# Using pdfminer.six ot extract the text 
# !pip install pdfminer.six
from pdfminer.high_level import extract_text
t = extract_text(name
, page_numbers=pages_to_summarize
)

print("Text extracted from " + name)
t
```

##### Zero-shot approach

A zero-shot example gets zero solved examples. We only provide it with
the command and the unsolved input. We will use the Instruct model that
has specifically been created to take in an instruction and record an
answer for it without an extra context, ideal for zero shot.

Now that we have text, let's walk through the progression of prompt
engineering to see how it can affect summary quality.

```python
#Using the text above from the Rathbone's report, we can try different prompts to see how it impacts the summary

prompt_i = 'Summarize the key financial information in the report using qualitative metrics.\n\nText:\n'+" ".join([normalize_text(t)])+'\n\nKey metrics:\n'

response = openai.Completion.create(
        engine="davinci-instruct",
        prompt = prompt_i,
        temperature = 0,
        max_tokens = 2048-int(len(prompt_i.split())*1.5),
        top_p = 1.0,
        frequency_penalty=0.5,
        presence_penalty = 0.5,
        # stop=['\n\n###\n\n'],
        best_of = 1
    )

print(response.choices[0].text)
```
    >>>
    - Funds under management and administration (FUMA) reached £54.7 billion at 31 December 2020, up 8.5% from £50.4 billion at 31 December 2019
    - Operating income totalled £366.1 million, 5.2% ahead of the prior year (2019: £348.1 million)
    - Underlying1 profit before tax totalled £92.5 million, an increase of 4.3% (2019: £88.7 million); underlying operating margin of 25.3% (2019: 25.5%)


```python
#Differnt prompt 
prompt_i = 'Extract most significant money related values of financial performance of the business like revenue, profit, etc. from the below text in about two hundred words.\n\nText:\n'+" ".join([normalize_text(t)])+'\n\nKey metrics:\n'
response = openai.Completion.create(
        engine=TEXT_DAVINCI_001,
        prompt = prompt_i,
        temperature = 0,
        max_tokens = 2048-int(len(prompt_i.split())*1.333),
        top_p = 1.0,
        frequency_penalty=0.5,
        presence_penalty = 0.5,
        # stop=['\n\n###\n\n'],
        best_of = 1
    )

print(response.choices[0].text)
```

    >>>
    - Funds under management and administration (FUMA) grew by 8.5% to reach £54.7 billion at 31 December 2020
    - Underlying profit before tax increased by 4.3% to £92.5 million, delivering an underlying operating margin of 25.3%
    - The board is announcing a final 2020 dividend of 47 pence per share, which brings the total dividend to 72 pence per share, an increase of 2.9% over 2019

*Challenges*:

1.  As we can see the model may come up with ghost metrics (never
    mentioned in the original text).

> Proposed solution: This can be changed by altering the prompt

2.  The summary may narrow on one section of the article, neglecting
    other important info

> Proposed solution: We can try a summary of summaries approach. We will
> chunk the report into sections, and gather smaller summaries that will
> be summarized together to form the output summary

```python
# Body of function

from pdfminer.high_level import extract_text
    
text = extract_text(name
, page_numbers=pages_to_summarize
)

r = splitter(200, text)

tok_l = int(2000/len(r))
tok_l_w = num2words(tok_l)

res_lis = []

# Stage 1: Summaries
for i in range(len(r)):
    prompt_i = f'Extract and summarize the key financial numbers and percentages mentioned in the Text in less than {tok_l_w} words.\n\nText:\n'+normalize_text(r[i])+'\n\nSummary in one paragraph:'
    response = openai.Completion.create(
        engine=TEXT_DAVINCI_001,
        prompt = prompt_i,
        temperature = 0,
        max_tokens = tok_l,
        top_p = 1.0,
        frequency_penalty=0.5,
        presence_penalty = 0.5,
        best_of = 1
    )
    t = response.choices[0].text
    
    t = trim_incomplete(t)
    res_lis.append(t)

# Stage 2: Summary of summaries
prompt_i = 'Summarize the financial performance of the business like revenue, profit, etc. in less than one hundred words. Do not make up values that are not mentioned in the Text.\n\nText:\n'+" ".join([normalize_text(res) for res in res_lis])+'\n\nSummary:\n'
response = openai.Completion.create(
        engine=TEXT_DAVINCI_001,
        prompt = prompt_i,
        temperature = 0,
        max_tokens = 200,
        top_p = 1.0,
        frequency_penalty=0.5,
        presence_penalty = 0.5,
        best_of = 1
    )

print(trim_incomplete(response.choices[0].text))
```

**Original text scraped from report:** \'Preliminary results for the
twelve months ended 31 December 2020 \\n\\nA resilient 2020 performance
\\n\\nPaul Stockton, chief executive, said: \\n\\n"Rathbones delivered a
resilient performance in an immensely challenging year. We continued to
deliver a high-quality service to \\nclients, whilst prioritising the
safety and wellbeing of our employees, advancing our strategy and
keeping a close eye on operating costs. \\n\\nFunds under management and
administration (FUMA) grew by 8.5% to reach £54.7 billion at 31 December
2020, reflecting both strong \\ninvestment performance and growth.
Underlying profit before tax increased by 4.3% to £92.5 million,
delivering an underlying \\noperating margin of 25.3% that was
consistent with the prior year despite lower investment markets.
\\n\\nAs a consequence, the board is announcing a final 2020 dividend of
47 pence per share, which brings the total dividend to 72 pence per
\\nshare, an increase of 2.9% over 2019. 2020 marks the 11th consecutive
year in which we have increased our total annual dividend. \\n\\nWhilst
we expect 2021 to remain volatile, our balance sheet is robust with a
strong capital position. Our near-term focus is to execute \\nour growth
strategy, to build our market share, to balance ongoing investment in
the business, and to continue to apply strict cost \\ndiscipline.
Rathbones will emerge stronger after the challenges of the pandemic
begin to subside." \\n\\nFinancial highlights \\n\\n--- Total FUMA
reached £54.7 billion at 31 December 2020, up 8.5% from £50.4 billion at
31 December 2019 \\n\\n--- £44.9 billion in the Investment Management
business, up 4.4% (2019: £43.0 billion) \\n--- £9.8 billion in the funds
business, up 32.4% (2019: £7.4 billion) \\n\\n--- Total net inflows
across the group were £2.1 billion (2019: £0.6 billion), representing a
growth rate of 4.2% (2019: 1.3%) \\n\\n--- Gross organic inflows in
Investment Management were consistent at £3.3 billion in 2020 compared
to £3.3 billion in the prior year \\n--- Acquired inflows of £0.6
billion in Investment Management largely reflect the transfer of assets
from Barclays Wealth (£0.4 billion) \\n--- Investment Management
outflows for the year totalled £3.3 billion (2019: £3.9 billion) \\n---
Net inflows in our funds business were £1.5 billion (2019: £0.9 billion)
\\n\\n--- Profit before tax for the twelve months to 31 December 2020
was £43.8 million (2019: £39.7 million). Basic earnings per share
totalled \\n\\n49.6p (2019: 50.3p) \\n\\n--- Operating income totalled
£366.1 million, 5.2% ahead of the prior year (2019: £348.1 million)
\\n\\n--- Operating income in Investment Management totalled £320.6
million, an increase of 3.1% on the prior period (2019: £310.9 million)
\\n--- Operating income in our funds business totalled £45.4 million, an
increase of 22.0% on the £37.2 million reported in 2019 \\n\\n---
Underlying1 profit before tax totalled £92.5 million, an increase of
4.3% (2019: £88.7 million); underlying operating margin of 25.3%
\\n\\n(2019: 25.5%) \\n\\n--- Underlying1 earnings per share totalled
133.3p (2019: 132.8p) \\n\\n1. A reconciliation between the underlying
measure and its closest IFRS equivalent is provided in Table 2 of the
financial performance section. \\n\\nDeclaration of final dividend
\\n\\nThe board recommends a final dividend of 47p for 2020 (2019: 45p),
making a total of 72p for the year (2019: 70p), an increase of 2.9% on
\\n2019. This reflects confidence in the outlook for the business and
its strong capital position. The dividend will be paid on \\n11 May
2021, subject to shareholder approval at our 2021 Annual General
Meeting, to shareholders on the register on 23 April 2021. \\n\\n1
\\n\\n \\n \\n \\n\\x0c\'

**Ground truth:** Rathbones has reported revenue of £366.1m in 2020, up
from £348.1m in 2019, and an increase in underlying profit before tax to
£92.5m from £88.7m. Assets under management rose 8.5% from £50.4bn to
£54.7bn, with assets in wealth management increasing 4.4% to £44.9bn.
Net inflows were £2.1bn in 2020 compared with £600m in the previous
year, driven primarily by £1.5bn inflows into its funds business and
£400m due to the transfer of assets from Barclays Wealth.

**Zero-shot summary of summaries model summary:** Rathbones delivered a
strong performance in 2020, with funds under management and
administration (FUMA) growing by 8.5% to reach £54.7 billion at the end
of the year. Underlying profit before tax increased by 4.3% to £92.5
million, delivering an underlying operating margin of 25.3%. Total net
inflows across the group were £2.1 billion, representing a growth rate
of 4.2%. Profit before tax for the year was £43.8 million, with basic
earnings per share totalling 49.6p. Operating income for the year was
5.2% ahead of the prior year, totalling £366.1 million.

##### Zero-Shot Summary of Summaries Observations

The zero-shot summary of summaries model works well for summarizing the
documents general nature. It can pick out key metrics and stays truthful
to the document provided.

## Results for Summary of Summaries 

Here are a subset of results using the zero shot summaries of summary
approach using the financial dataset.

| Report URL | Ground Truth (Nielson Summary) | Zero Shot |
|------------|--------------------------------|-----------|
| https://www.rathbones.com/sites/rathbones.com/files/imce/rathbones_2020_preliminary_results_announcement_-_final-.pdf|  Rathbones has reported revenue of £366.1m in 2020, up from £348.1m in 2019, and an increase in underlying profit before tax to £92.5m from £88.7m. Assets under management rose 8.5% from £50.4bn to £54.7bn, with assets in wealth management increasing 4.4% to £44.9bn. Net inflows were £2.1bn in 2020 compared with £600m in the previous year, driven primarily by £1.5bn inflows into its funds business and £400m due to the transfer of assets from Barclays Wealth. |Rathbones delivered a strong performance in 2020, with funds under management and administration (FUMA) growing by 8.5% to reach £54.7 billion at the end of the year. Underlying profit before tax increased by 4.3% to £92.5 million, delivering an underlying operating margin of 25.3%. Total net inflows across the group were £2.1 billion, representing a growth rate of 4.2%. Profit before tax for the year was £43.8 million, with basic earnings per share totalling 49.6p. Operating income for the year was 5.2% ahead of the prior year, totalling £366.1 million.|
|https://www.sjp.co.uk/~/media/Files/S/SJP-Corp/document-library/results/2021/sjp-half-year-results-press-release-2021.pdf|St James’s Place has reported an EEV operating profit of £844.8m for H1 2021 (2020: £418.7m) and an IFRS profit after tax of £120.9m (2020: £178.1m). Gross inflows increased to £9.2bn (2020: £7.3bn) and net inflows increased to £5.5bn (2020: £4.5bn). |The company has seen strong new business and financial performance in the first half of the year, with gross inflows of £9.2 billion, a retention rate of 96%, and net inflows of £5.5 billion. The group's funds under management have increased to £143.8 billion. The underlying cash result was £189.3 million, the EEV operating profit was £844.8 million, and the IFRS profit after tax was £120.9 million. The interim dividend was 11.55 pence per share.|
|https://www.brewin.co.uk/sites/brewin-corp-v2/files/press-release/pr-pdf/brw-q3-2021-trading-update.pdf|Brewin Dolphin has registered its second successive quarter of record inflows in the three months to 30 June 2021, with new clients accounting for 70% of the £1.3bn gross figure. It reported a 6.5% jump in assets under management from £52.6bn at the end of March 2021 to £56bn, which was 22% higher year-on-year.|Brewin Dolphin Holdings PLC announced a trading update for the three months ended 30 June 2021, with Q3 discretionary net flows of £0.7bn, an annualized growth of 6.1%. The company is pleased to announce a second consecutive quarter of record gross discretionary fund inflows, with strong fund inflows across both its direct and indirect businesses. Implementation of its custody and settlement system remains on track for the Autumn. The company reports strong growth across both its direct and indirect businesses, with over 70% of gross discretionary fund inflows coming from new clients. Ireland contributed around a quarter of the company's gross direct inflows, while Voyager funds grew by £100m to £250m. Total income increased by 12%, driven by higher market performance and strong fund net flows. The company's total discretionary income has grown by 11.5% to £255.0m, with commission income from corporate transactions down from elevated levels in Q2.|
|https://www.paragonbankinggroup.co.uk/resources/paragon-group/documents/reports-presentations/2022/paragonbankinggroup_q1_tradingupdate_2022| Paragon Banking has reported that total new lending in Q4 2021 increased by 35.7% to £708m from £521.8m in Q1 2020/21, with the volume of new buy-to-let mortgage advances increasing by 36.8% to £408.5m compared to the £298.7m in Q1 2020/21. Deposit balances increased further to £9.6bn in the period, with the portfolio average deposit rate at the end of December 2021 decreasing to 0.90% compared to the 1.22% reported at the end of December 2020.|The Group's revenue increased by 35.7% to £708.0 million from £521.8 million in Q1 2020/21, with a focus on lending to specialist landlords. The company's Commercial Lending business lines saw double-digit percentage improvements from the comparable quarter, and the Group's impairment assessments are being updated with its half year results. The company's digitalisation programme is progressing well, with costs in line with guidance. |

## 

## Conclusions

There are many ways to approach summarization utilizing GPT-3. Each
approach (zero shot, few shot, fine tuning) produces different types of
summaries. Based on your use case, you can explore which type of summary
produces the best results for your intended use case.

A few observations from our explorations:

-   Zero-shot will try to capture the entire text in a very human-like
    manner. It will capture high level information in a succinct manner.
    This approach resulted in high quality summaries for both datasets.
    This approach is best for documents that are general in nature.
-   Few-shot for long text summarization proves to be challenging to
    stay under the token limit for prompt engineering. This approach was
    unsuccessful given our data.
-   Finetuning will capture the summary in a few templated ways, trying
    to conform to how the dataset presents the summaries. Finetuning is
    useful for technically or domain specific uses cases where the
    information is not commonly available.

Our recommendations:

-   **Zero-shot** is best for documents that are general in nature and
    do not require specific domain knowledge. This will provide a
    high-quality baseline summary.
-   **Few-shot** proves difficult for long document summarization
    because providing an example text will surpass the token limitation.
    To combat this, a zero-shot summary of summaries approach can be
    used for long documents or increasing the dataset to enable
    successful finetuning.
-   **Finetuning** is most useful for technically or domain specific use
    cases where the information is not readily available. This requires
    a dataset of a couple thousand samples for the best results.

There are multiple techniques to evaluate the performance of
summarization models. Below are a few examples: 

ROUGE stands for Recall-Oriented Understudy for Gisting Evaluation. It
includes measures to automatically determine the quality of a summary by
comparing it to other (ideal) summaries created by humans. The measures
count the number of overlapping units such as n-gram, word sequences,
and word pairs between the computer-generated summary to be evaluated
and the ideal summaries created by humans. 

![Rogue score example](https://github.com/Azure/openai-samples/blob/4b5374f4e71e4b08663205942d9b2e1f80dbb2fe/Solution_Notebooks/Query_Based_Summarization/images/figure2.png)
<figcaption align = "center"><b>Figure 2: Rogue score example</b></figcaption>

BertScore (Zhang et al., 2020) computes similarity scores by aligning
generated and reference summaries on a token-level. Token alignments are
computed greedily to maximize the cosine similarity between
contextualized token embeddings from BERT. 

![Bert score example](https://github.com/Azure/openai-samples/blob/d65153f132d134bacdc9fe68b006137f98ea2e49/Solution_Notebooks/Query_Based_Summarization/images/figure4.png)
<figcaption align = "center"><b>Figure 3: BERT score example</b></figcaption>

Or use  bert-score-show \--lang en -r \"The cat is on the porch by the
tree\" -c \"The cat is by the tree on the porch\" -f out.png 

For 

![Similarity matrix example](https://github.com/Azure/openai-samples/blob/4b5374f4e71e4b08663205942d9b2e1f80dbb2fe/Solution_Notebooks/Query_Based_Summarization/images/figure3.png)
<figcaption align = "center"><b>Figure 4: Similarity matrix example</b></figcaption>

For a more comprehensive list and unified metrics in Pypi package,
please refer to the following paper:
<https://direct.mit.edu/tacl/article/doi/10.1162/tacl_a_00373/100686/SummEval-Re-evaluating-Summarization-Evaluation>
and <https://pypi.org/project/summ-eval/> 

## Appendix

1\. Citations

BILLSUM is the base dataset for our work.

> *\@misc{kornilova2019billsum,*
>
> *    title={BillSum: A Corpus for Automatic Summarization of US
> Legislation},*
>
> *    author={Anastassia Kornilova and Vlad Eidelman},*
>
> *    year={2019},*
>
> *    eprint={1910.00523},*
>
> *    archivePrefix={arXiv},*
>
> *    primaryClass={cs.CL}*
>
> *}*

2.  Sample bill text:

#### SAMPLE_BILL_1

    SECTION 1. SHORT TITLE.

        This Act may be cited as the ``National Science Education Tax 
    Incentive for Businesses Act of 2007''.

    SEC. 2. CREDITS FOR CERTAIN CONTRIBUTIONS BENEFITING SCIENCE, 
                  TECHNOLOGY, ENGINEERING, AND MATHEMATICS EDUCATION AT THE 
                  ELEMENTARY AND SECONDARY SCHOOL LEVEL.

        (a) In General.--Subpart D of part IV of subchapter A of chapter 1 
    of the Internal Revenue Code of 1986 (relating to business related 
    credits) is amended by adding at the end the following new section:

    ``SEC. 45O. CONTRIBUTIONS BENEFITING SCIENCE, TECHNOLOGY, ENGINEERING, 
                  AND MATHEMATICS EDUCATION AT THE ELEMENTARY AND SECONDARY 
                  SCHOOL LEVEL.

        ``(a) In General.--For purposes of section 38, the elementary and 
    secondary science, technology, engineering, and mathematics (STEM) 
    contributions credit determined under this section for the taxable year 
    is an amount equal to 100 percent of the qualified STEM contributions 
    of the taxpayer for such taxable year.
        ``(b) Qualified STEM Contributions.--For purposes of this section, 
    the term `qualified STEM contributions' means--
                ``(1) STEM school contributions,
                ``(2) STEM teacher externship expenses, and
                ``(3) STEM teacher training expenses.
        ``(c) STEM School Contributions.--For purposes of this section--
                ``(1) In general.--The term `STEM school contributions' 
            means--
                        ``(A) STEM property contributions, and
                        ``(B) STEM service contributions.
                ``(2) STEM property contributions.--The term `STEM property 
            contributions' means the amount which would (but for subsection 
            (f)) be allowed as a deduction under section 170 for a 
            charitable contribution of STEM inventory property if--
                        ``(A) the donee is an elementary or secondary 
                    school described in section 170(b)(1)(A)(ii),
                        ``(B) substantially all of the use of the property 
                    by the donee is within the United States or within the 
                    defense dependents' education system for educational 
                    purposes in any of the grades K-12 that are related to 
                    the purpose or function of the donee,
                        ``(C) the original use of the property begins with 
                    the donee,
                        ``(D) the property will fit productively into the 
                    donee's education plan,
                        ``(E) the property is not transferred by the donee 
                    in exchange for money, other property, or services, 
                    except for shipping, installation and transfer costs, 
                    and
                        ``(F) the donee's use and disposition of the 
                    property will be in accordance with the provisions of 
                    subparagraphs (B) and (E).
            The determination of the amount of deduction under section 170 
            for purposes of this paragraph shall be made as if the 
            limitation under section 170(e)(3)(B) applied to all STEM 
            inventory property.
                ``(3) STEM service contributions.--The term `STEM service 
            contributions' means the amount paid or incurred during the 
            taxable year for STEM services provided in the United States or 
            in the defense dependents' education system for the exclusive 
            benefit of students at an elementary or secondary school 
            described in section 170(b)(1)(A)(ii) but only if--
                        ``(A) the taxpayer is engaged in the trade or 
                    business of providing such services on a commercial 
                    basis, and
                        ``(B) no charge is imposed for providing such 
                    services.
                ``(4) STEM inventory property.--The term `STEM inventory 
            property' means, with respect to any contribution to a school, 
            any property--
                        ``(A) which is described in paragraph (1) or (2) of 
                    section 1221(a) with respect to the donor, and
                        ``(B) which is determined by the school to be 
                    needed by the school in providing education in grades 
                    K-12 in the areas of science, technology, engineering, 
                    or mathematics.
                ``(5) STEM services.--The term `STEM services' means, with 
            respect to any contribution to a school, any service determined 
            by the school to be needed by the school in providing education 
            in grades K-12 in the areas of science, technology, 
            engineering, or mathematics, including teaching courses of 
            instruction at such school in any such area.
                ``(6) Defense dependents' education system.--For purposes 
            of this subsection, the term `defense dependents' education 
            system' means the program established and operated under the 
            Defense Dependents' Education Act of 1978 (20 U.S.C. 921 et 
            seq.).
        ``(d) STEM Teacher Externship Expenses.--For purposes of this 
    section--
                ``(1) In general.--The term `STEM teacher externship 
            expenses' means any amount paid or incurred to carry out a STEM 
            externship program of the taxpayer but only to the extent that 
            such amount is attributable to the participation in such 
            program of any eligible STEM teacher, including amounts paid to 
            such a teacher as a stipend while participating in such 
            program.
                ``(2) STEM externship program.--The term `STEM externship 
            program' means any program--
                        ``(A) established by a taxpayer engaged in a trade 
                    or business within an area of science, technology, 
                    engineering, or mathematics, and
                        ``(B) under which eligible STEM teachers receive 
                    training to enhance their teaching skills in the areas 
                    of science, technology, engineering, or mathematics or 
                    otherwise improve their knowledge in such areas.
                ``(3) Eligible stem teacher.--The term `eligible STEM 
            teacher' means any individual--
                        ``(A) who is a teacher in grades K-12 at an 
                    educational organization described in section 
                    170(b)(1)(A)(ii) which is located in the United States 
                    or which is located on a United States military base 
                    outside the United States, and
                        ``(B) whose teaching responsibilities at such 
                    school include, or are likely to include, any course in 
                    the areas of science, technology, engineering, or 
                    mathematics.
        ``(e) STEM Teacher Training Expenses.--The term `STEM teacher 
    training expenses' means any amount paid or incurred by a taxpayer 
    engaged in a trade or business within an area of science, technology, 
    engineering, or mathematics which is attributable to the participation 
    of any eligible STEM teacher in a regular training program provided to 
    employees of the taxpayer which is determined by such teacher's school 
    as enhancing such teacher's teaching skills in the areas of science, 
    technology, engineering, or mathematics.
        ``(f) Denial of Double Benefit.--No deduction shall be allowed 
    under this chapter for any amount allowed as a credit under this 
    section.''.
        (b) Conforming Amendments.--
                (1) Section 38(b) of such Code is amended by striking 
            ``plus'' at the end of paragraph (30), by striking the period 
            at the end of paragraph (31), and inserting ``, plus'', and by 
            adding at the end the following new paragraph:
                ``(32) the elementary and secondary science, technology, 
            engineering, and mathematics (STEM) contributions credit 
            determined under section 45O.''.
                (2) The table of sections for subpart D of part IV of 
            subchapter A of chapter 1 of such Code is amended by adding at 
            the end the following new item:

    ``Sec. 45O. Contributions benefiting science, technology, engineering, 
                                and mathematics education at the elementary 
                                and secondary school level.''.
        (c) Effective Date.--The amendments made by this section shall 
    apply to taxable years beginning after the date of the enactment of 
    this Act.

#### SAMPLE_BILL_2

    SECTION 1. SHORT TITLE.

        This Act may be cited as the ``Small Business Expansion and Hiring 
    Act of 2011''.

    SEC. 2. BUSINESS CREDIT FOR RETENTION OF CERTAIN INDIVIDUALS NEWLY 
                HIRED BEFORE 2013.

        (a) In General.--Subpart D of part IV of subchapter A of chapter 1 
    of the Internal Revenue Code of 1986 (relating to business-related 
    credits) is amended by adding at the end the following new section:

    SEC. 45S. RETENTION OF CERTAIN INDIVIDUALS NEWLY HIRED BEFORE 2013.

        (a) In General.--For purposes of section 38, in the case of any 
    taxable year ending after the date of the enactment of this section and 
    beginning before January 1, 2013, the retained worker credit determined 
    under this section for the taxable year is the aggregate of the lesser 
    of--
                (1) $4,000 ($6,000 in the case of a long-term unemployed 
            individual), or
                (2) 6.2 percent of the wages (as defined in section 
            3401(a)) paid by the taxpayer to such retained worker during 
            the 52 consecutive week period referred to in subsection 
            (c)(2).
        (b) Limitations.--
                (1) Increase in employment.--The number of retained 
            workers taken into account under subsection (a) shall not 
            exceed the excess of (if any)--
                        (A) the number of employees of the taxpayer at 
                    the end of the taxable year, over
                        (B) the number of employees of the taxpayer at 
                    the beginning of the taxable year.
                (2) Dollar limitation.--The amount allowed as a credit 
            under subsection (a) for a taxable year with respect to any 
            business location of the employer shall not exceed $400,000.
                (3) Special rules.--
                        (A) Business-location specific.--All 
                    determinations under this section regarding the number 
                    of employees shall be determined on a location basis.
                        (B) Employees rotated among business not 
                    eligible.--An employee who is moved from one location 
                    of the taxpayer to another location shall not be taken 
                    into account for purposes of paragraph (1).
        (c) Definitions.--For purposes of this section--
                (1) Retained worker.--The term retained worker' means 
            any qualified individual--
                        (A) who was employed by the taxpayer on any date 
                    during the taxable year,
                        (B) who was so employed by the taxpayer for a 
                    period of not less than 52 consecutive weeks, and
                        (C) whose wages (as defined in section 3401(a)) 
                    for such employment during the last 26 weeks of such 
                    period equaled at least 80 percent of such wages for 
                    the first 26 weeks of such period.
                (2) Qualified individual.--The term qualified 
            individual' means any individual who--
                        (A) begins employment with a qualified employer 
                    after December 31, 2010, and before January 1, 2014,
                        (B) certifies by signed affidavit, under 
                    penalties of perjury, that such individual has not been 
                    employed for 40 hours or more per week during the 60-
                    day period ending on the date such individual begins 
                    such employment,
                        (C) is not employed by the qualified employer to 
                    replace another employee of such employer unless such 
                    other employee separated from employment voluntarily or 
                    for cause, and
                        (D) is not an individual described in section 
                    51(i)(1) (applied by substituting `qualified employer' 
                    for `taxpayer' each place it appears).
                (3) Qualified employer.--
                        (A) In general.--The term qualified employer' 
                    means any employer other than the United States, any 
                    State, or any political subdivision thereof, or any 
                    instrumentality of the foregoing which employed an 
                    average of less than 100 employees on business days 
                    during such taxable year.
                        (B) Treatment of employees of post-secondary 
                    educational institutions.--Notwithstanding subparagraph 
                    (A), the term `qualified employer' includes any 
                    employer which is a public institution of higher 
                    education (as defined in section 101(b) of the Higher 
                    Education Act of 1965).
                (4) Long-term unemployed individual.--The term long-term 
            unemployed individual' means an individual who was in receipt 
            of unemployment compensation under State or Federal law for not 
            less than 26 weeks during the 1-year period ending on the day 
            the individual is hired by the employer.''.
        (b) Credit Allowed as Business Credit.--Section 38(b) of the 
    Internal Revenue Code of 1986 (relating to current year business 
    credit) is amended by striking ``plus'' at the end of paragraph (35), 
    by striking the period at the end of paragraph (36) and inserting ``, 
    plus'', and by adding at the end the following new paragraph:
                (37) the retained worker credit determined under section 
            45S.''.
        (c) Limitation on Carryforward.--Section 39(a) of such Code is 
    amended by adding at the end the following:
                ``(5) 3-year carryforward for retained worker credit.--In 
            the case of the retained worker credit, paragraph (2) shall be 
            applied--
                        (A) by substituting 3 taxable years' for 21 
                    taxable years' in subparagraph (A) thereof, and
                        (B) by substituting 2 taxable years' for 20 
                    taxable years' in subparagraph (B) thereof.''.
        (d) Clerical Amendment.--The table of sections for subpart D of 
    part IV of subchapter A of chapter 1 of the Internal Revenue Code of 
    1986 is amended by inserting after the item relating to section 45R the 
    following new item:

    Sec. 45S. Retention of certain individuals newly hired before 
                                2013.''.
        (e) Effective Date.--The amendments made by this section shall 
    apply to taxable years beginning after the date of the enactment of 
    this Act.

#### SAMPLE_BILL_3

    SECTION 1. RELEASE OF DOCUMENTS CAPTURED IN IRAQ AND AFGHANISTAN.

        (a) In General.--The Director of National Intelligence shall make 
    publicly available on an Internet website all captured documents.
        (b) Review by Director of National Intelligence.--The Director of 
    National Intelligence may review a captured document before making such 
    document publicly available under subsection (a). The Director shall 
    not be required to make a captured document publicly available under 
    subsection (a) if--
                (1) in the case of a captured document that is reviewed by 
            the Director before the date of the enactment of this Act, the 
            Director submits to the relevant congressional committees a 
            description of the criteria the Director used to determine it 
            is not appropriate to make a captured document publicly 
            available and such captured document meets such criteria; or
                (2) in the case of a captured document that is reviewed by 
            the Director on or after the date of the enactment of this Act, 
            the Director submits to the relevant congressional committees a 
            description of the criteria the Director shall use to determine 
            if it is not appropriate to make a captured document publicly 
            available and the captured document meets such criteria.
        (c) Submission of Description of Non-Released Documents.--
                (1) Review before date of enactment.--Not later than 90 
            days after the date of the enactment of this Act, the Director 
            of National Intelligence shall submit to the relevant 
            congressional committees a report containing--
                        (A) a description of each captured document that, 
                    before such date, the Director determined should not be 
                    made publicly available; and
                        (B) an explanation as to why the Director does not 
                    consider it appropriate to make such captured document 
                    publicly available.
                (2) Review after date of enactment.--Not later than 30 days 
            after the Director of National Intelligence determines that a 
            captured document should not be made publicly available 
            pursuant to subsection (b)(2), the Director shall submit to the 
            relevant congressional committees a report containing a 
            description of such captured document and an explanation as to 
            why the Director does not consider it appropriate to make such 
            document publicly available.
                (3) Request for document.--The Director of National 
            Intelligence shall make a copy of each captured document 
            available to the relevant congressional committees for review 
            upon request of the Chairman of any of such relevant 
            congressional committees. The Director shall make such copy 
            available in either classified or unclassified form.
        (d) Publication or Review Date.--
                (1) In general.--The Director of National Intelligence 
            shall begin making captured documents publicly available 
            pursuant to subsection (a) not later than 30 days after the 
            date of the enactment of this Act.
                (2) Documents collected prior to date of enactment.--
                        (A) In general.--Not later than the date described 
                    in subparagraph (B), for each captured document 
                    captured or collected before the date of the enactment 
                    of this Act, the Director of National Intelligence 
                    shall make such captured document publicly available 
                    pursuant to subsection (a) or shall submit to the 
                    relevant congressional committees a report regarding 
                    such captured document pursuant to subsection (c).
                        (B) Dates.--The date described in this subparagraph 
                    is--
                                (i) September 30, 2006, for captured 
                            documents captured or collected during 
                            Operation Enduring Freedom and Operation Iraqi 
                            Freedom; and
                                (ii) March 31, 2007, for captured documents 
                            captured or collected during Operation Desert 
                            Storm.
                (3) Documents collected after date of enactment.--For each 
            captured document that is captured or collected on or after the 
            date of the enactment of this Act, not later than 60 days after 
            the date on which such captured document is captured or 
            collected, the Director of National Intelligence shall make 
            such captured document publicly available pursuant to 
            subsection (a) or shall submit to the relevant congressional 
            committees a report regarding such captured document pursuant 
            to subsection (c).
        (e) Weekly Report.--Not later than 7 days after the date of 
    enactment of this Act, and weekly thereafter until each captured 
    document captured or collected before the date of the enactment of this 
    Act is made publicly available pursuant to subsection (a) or described 
    in a report submitted pursuant to subsection (c), the Director of 
    National Intelligence shall submit to the relevant congressional 
    committees a report describing the progress in making captured 
    documents publicly available.
        (f) Definitions.--In this section:
                (1) Captured document.--The term ``captured document'' 
            means a document captured or collected in Afghanistan or Iraq, 
            including a document collected from the Government of Iraq or 
            from a private person and including a document in electronic 
            form, during Operation Desert Storm, Operation Enduring 
            Freedom, and Operation Iraqi Freedom.
                (2) Relevant congressional committees.--The term ``relevant 
            congressional committees'' means the Permanent Select Committee 
            on Intelligence of the House of Representatives and Select 
            Committee on Intelligence of the Senate.


#### SAMPLE_BILL_4

    SECTION 1. SHORT TITLE.

        This Act may be cited as the ``Military Call-Up Relief Act''.

    SEC. 2. WAIVER OF EARLY WITHDRAWAL PENALTY FOR DISTRIBUTIONS FROM 
                  QUALIFIED RETIREMENT PLANS TO INDIVIDUALS CALLED TO 
                  ACTIVE DUTY DURING THE NATIONAL EMERGENCY DECLARED BY THE 
                  PRESIDENT ON SEPTEMBER 14, 2001.

        (a) Waiver For Certain Distributions.--
                (1) In general.--Section 72(t)(2) of the Internal Revenue 
            Code of 1986 (relating to 10-percent additional tax on early 
            distributions from qualified retirement plans) is amended by 
            adding at the end the following:
                        ``(G) Distributions to individuals performing 
                    national emergency active duty.--Any distribution to an 
                    individual who, at the time of the distribution, is a 
                    member of a reserve component called or ordered to 
                    active duty pursuant to a provision of law referred to 
                    in section 101(a)(13)(B) of title 10, United States 
                    Code, during the period of the national emergency 
                    declared by the President on September 14, 2001.''.
                (2) Waiver of underpayment penalty.--Section 6654(e)(3) of 
            such Code (relating to waiver in certain cases) is amended by 
            adding at the end the following:
                        ``(C) Certain early withdrawals from retirement 
                    plans.--No addition to tax shall be imposed under 
                    subsection (a) with respect to any underpayment to the 
                    extent such underpayment was created or increased by 
                    any distribution described in section 72(t)(2)(G).''.
                (3) Effective date.--The amendments made by this subsection 
            shall apply to distributions made to an individual after 
            September 13, 2001.
        (b) Catch-up Contributions Allowed.--
                (1) Individual retirement accounts.--Section 219(b)(5) of 
            the Internal Revenue Code of 1986 (relating to deductible 
            amount) is amended by adding at the end the following:
                        ``(D) Catch-up contributions for certain 
                    distributions.--In the case of an individual who has 
                    received a distribution described in section 
                    72(t)(2)(G), the deductible amount for any taxable year 
                    shall be increased by an amount equal to--
                                ``(i) the aggregate amount of such 
                            distributions (not attributable to earnings) 
                            made with respect to such individual, over
                                ``(ii) the aggregate amount of such 
                            distributions (not attributable to earnings) 
                            previously taken into account under this 
                            subparagraph or section 414(w).''.
                (2) Roth iras.--Section 408A(c) of such Code (relating to 
            treatment of contributions) is amended by redesignating 
            paragraph (7) as paragraph (8) and by inserting after paragraph 
            (6) the following:
                ``(7) Catch-up contributions for certain distributions.--
            Any contribution described in section 219(b)(5)(D) shall not be 
            taken into account for purposes of paragraph (2).''.
                (3) Employer plans.--Section 414 of such Code (relating to 
            definitions and special rules) is amended by adding at the end 
            the following:
        ``(w) Catch-up contributions for certain distributions.--
                ``(1) In general.--An applicable employer plan shall not be 
            treated as failing to meet any requirement of this title solely 
            because the plan permits an applicable participant to make 
            additional elective deferrals in any plan year.
                ``(2) Limitation on amount of additional deferrals.--
                        ``(A) In general.--A plan shall not permit 
                    additional elective deferrals under paragraph (1) for 
                    any year in an amount greater than the lesser of--
                                ``(i) the applicable dollar amount, or
                                ``(ii) the excess (if any) of--
                                        ``(I) the participant's 
                                    compensation (as defined in section 
                                    415(c)(3)) for the year, over
                                        ``(II) any other elective deferrals 
                                    of the participant for such year which 
                                    are made without regard to this 
                                    subsection.
                        ``(B) Applicable dollar amount.--For purposes of 
                    this paragraph, the applicable dollar amount with 
                    respect to a participant shall be an amount equal to--
                                ``(i) the aggregate amount of distributions 
                            described in section 72(t)(2)(G) (not 
                            attributable to earnings) made with respect to 
                            such participant, over
                                ``(ii) the aggregate amount of such 
                            distributions (not attributable to earnings) 
                            previously taken into account under this 
                            subsection or section 219(b)(5)(B).
                ``(3) Treatment of contributions.--Rules similar to the 
            rules of paragraphs (3) and (4) of subsection (v) shall apply 
            with respect to contributions made under this subsection.
                ``(4) Definitions.--For purposes of this subsection, the 
            terms `applicable employer plan' and `elective deferral' have 
            the same meanings given such terms in subsection (v)(6).''.
                (4) Conforming amendment.--Section 414(v)(2)(A)(ii)(II) of 
            such Code (relating to limitation on amount of additional 
            deferrals) is amended by inserting ``(other than deferrals 
            under subsection (w))'' after ``deferrals''.
                (5) Effective date.--The amendments made by this subsection 
            shall apply to contributions in taxable years ending after 
            December 31, 2001.'''


#### SAMPLE_BILL_5

    SECTION 1. SHORT TITLE.

        This Act may be cited as the ``Service Dogs for Veterans Act of 
    2009''.

    SEC. 2. PILOT PROGRAM ON USE OF SERVICE DOGS FOR THE TREATMENT OR 
                  REHABILITATION OF VETERANS WITH PHYSICAL OR MENTAL 
                  INJURIES OR DISABILITIES.

        (a) Findings.--Congress makes the following findings:
                (1) The United States owes a profound debt to those who 
            have served the United States honorably in the Armed Forces.
                (2) Disabled veterans suffer from a range of physical and 
            mental injuries and disabilities.
                (3) In 2008, the Army reported the highest level of 
            suicides among its soldiers since it began tracking the rate 28 
            years before 2009.
                (4) A scientific study documented in the 2008 Rand Report 
            entitled ``Invisible Wounds of War'' estimated that 300,000 
            veterans of Operation Enduring Freedom and Operation Iraqi 
            Freedom currently suffer from post-traumatic stress disorder.
                (5) Veterans have benefitted in multiple ways from the 
            provision of service dogs.
                (6) The Department of Veterans Affairs has been 
            successfully placing guide dogs with the blind since 1961.
                (7) Thousands of dogs around the country await adoption.
        (b) Program Required.--Not later than 120 days after the date of 
    the enactment of this Act, the Secretary of Veterans Affairs shall 
    commence a three-year pilot program to assess the benefits, 
    feasibility, and advisability of using service dogs for the treatment 
    or rehabilitation of veterans with physical or mental injuries or 
    disabilities, including post-traumatic stress disorder.
        (c) Partnerships.--
                (1) In general.--The Secretary shall carry out the pilot 
            program by partnering with nonprofit organizations that--
                        (A) have experience providing service dogs to 
                    individuals with injuries or disabilities;
                        (B) do not charge fees for the dogs, services, or 
                    lodging that they provide; and
                        (C) are accredited by a generally accepted 
                    industry-standard accrediting institution.
                (2) Reimbursement of costs.--The Secretary shall reimburse 
            partners for costs relating to the pilot program as follows:
                        (A) For the first 50 dogs provided under the pilot 
                    program, all costs relating to the provision of such 
                    dogs.
                        (B) For dogs provided under the pilot program after 
                    the first 50 dogs provided, all costs relating to the 
                    provision of every other dog.
        (d) Participation.--
                (1) In general.--As part of the pilot program, the 
            Secretary shall provide a service dog to a number of veterans 
            with physical or mental injuries or disabilities that is 
            greater than or equal to the greater of--
                        (A) 200; and
                        (B) the minimum number of such veterans required to 
                    produce scientifically valid results with respect to 
                    assessing the benefits and costs of the use of such 
                    dogs for the treatment or rehabilitation of such 
                    veterans.
                (2) Composition.--The Secretary shall ensure that--
                        (A) half of the participants in the pilot program 
                    are veterans who suffer primarily from a mental health 
                    injury or disability; and
                        (B) half of the participants in the pilot program 
                    are veterans who suffer primarily from a physical 
                    injury or disability.
        (e) Study.--In carrying out the pilot program, the Secretary shall 
    conduct a scientifically valid research study of the costs and benefits 
    associated with the use of service dogs for the treatment or 
    rehabilitation of veterans with physical or mental injuries or 
    disabilities. The matters studied shall include the following:
                (1) The therapeutic benefits to such veterans, including 
            the quality of life benefits reported by the veterans partaking 
            in the pilot program.
                (2) The economic benefits of using service dogs for the 
            treatment or rehabilitation of such veterans, including--
                        (A) savings on health care costs, including savings 
                    relating to reductions in hospitalization and 
                    reductions in the use of prescription drugs; and
                        (B) productivity and employment gains for the 
                    veterans.
                (3) The effectiveness of using service dogs to prevent 
            suicide.
        (f) Reports.--
                (1) Annual report of the secretary.--After each year of the 
            pilot program, the Secretary shall submit to Congress a report 
            on the findings of the Secretary with respect to the pilot 
            program.
                (2) Final report by the national academy of sciences.--Not 
            later than 180 days after the date of the completion of the 
            pilot program, the National Academy of Sciences shall submit to 
            Congress a report on the results of the pilot program.
    

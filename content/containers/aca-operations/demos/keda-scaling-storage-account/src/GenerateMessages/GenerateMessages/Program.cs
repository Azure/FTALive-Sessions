using Azure.Storage.Queues;
using Azure.Storage.Queues.Models;
using Microsoft.Extensions.Configuration;

try
{
    var builder = new ConfigurationBuilder()
        .SetBasePath(Directory.GetCurrentDirectory())
        .AddJsonFile("appsettings.json", optional: false, reloadOnChange: true);

    IConfigurationRoot configuration = builder.Build();

    string connectionString = configuration["ConnectionString"];
    string queueName = configuration["QueueName"];

    Console.WriteLine("Processing Message for Azure Storage Queue ...");
    Console.WriteLine("Start ...");
    QueueClient queueClient = new QueueClient(connectionString, queueName);

    for (int i = 1; i <= 100000; i++)
    {
        string message = $"Message {Guid.NewGuid()}";
        await InsertMessageAsync(queueClient, message);
        Console.WriteLine($"Sent: {message}");
    }
    Console.WriteLine("Completed. Message dropped in Queue OK!");

    Console.Write("Finished - Press Enter...");
    Console.ReadLine();
}
catch (Exception ex)
{
	throw ex;
}

static async Task InsertMessageAsync(QueueClient queueClient, string newMessage)
{
    await queueClient.SendMessageAsync(newMessage);
}

static async Task<string> RetrieveNextMessageAsync(QueueClient queueClient)
{
    QueueMessage[] retrievedMessage = await queueClient.ReceiveMessagesAsync();
    string messageText = retrievedMessage[0].MessageText;
    await queueClient.DeleteMessageAsync(retrievedMessage[0].MessageId, retrievedMessage[0].PopReceipt);
    return messageText;
}
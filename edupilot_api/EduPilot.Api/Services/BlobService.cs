using Azure;
using Azure.Storage;
using Azure.Storage.Blobs;
using Azure.Storage.Blobs.Models;
using Azure.Storage.Sas;
using EduPilot.Api.Data.Models;

namespace EduPilot.Api.Services
{
    public class BlobService
    {
        private readonly string _questionContainerName;
        private readonly string _publishersContainerName;
        private readonly string _institutionsContainerName;
        private readonly string _connectionString;
        private readonly string _accountName;
        private readonly string _accountKey;

        public BlobService(IConfiguration configuration)
        {
            _questionContainerName = configuration["AzureBlobStorage:QuestionContainerName"];
            _publishersContainerName = configuration["AzureBlobStorage:PublishersContainerName"];
            _institutionsContainerName = configuration["AzureBlobStorage:InstitutionsContainerName"];
            _connectionString = configuration.GetConnectionString("StorageAccount");
            _accountName = configuration["AzureBlobStorage:AccountName"];
            _accountKey = configuration["AzureBlobStorage:AccountKey"];
        }

        public async Task<string> UploadQuestionFileAsync(IFormFile file, Guid quizId, Guid questionId)
        {
            var blobServiceClient = new BlobServiceClient(_connectionString);
            var containerClient = blobServiceClient.GetBlobContainerClient(_questionContainerName);
            await containerClient.CreateIfNotExistsAsync(PublicAccessType.None);

            // Compose the blob name like: quizId/questionId/filename.ext
            var fileName = Path.GetFileName(file.FileName);
            var blobName = $"{quizId}/{questionId}/{fileName}";

            var blobClient = containerClient.GetBlobClient(blobName);

            using var stream = file.OpenReadStream();
            await blobClient.UploadAsync(stream, overwrite: true);

            return blobClient.Uri.ToString(); // Save this in your DB
        }

        public async Task<string> UploadPublisherLogoFileAsync(IFormFile file, Guid publisherId)
        {
            var blobServiceClient = new BlobServiceClient(_connectionString);
            var containerClient = blobServiceClient.GetBlobContainerClient(_publishersContainerName);
            await containerClient.CreateIfNotExistsAsync(PublicAccessType.None);

            // Compose the blob name like: quizId/questionId/filename.ext
            var fileName = Path.GetFileName(file.FileName);
            var blobName = $"{publisherId}/{fileName}";

            var blobClient = containerClient.GetBlobClient(blobName);

            using var stream = file.OpenReadStream();
            await blobClient.UploadAsync(stream, overwrite: true);

            return blobClient.Uri.ToString(); // Save this in your DB
        }

        public async Task<string> UploadInstitutionLogoFileAsync(IFormFile file, Guid institutionId)
        {
            var blobServiceClient = new BlobServiceClient(_connectionString);
            var containerClient = blobServiceClient.GetBlobContainerClient(_institutionsContainerName);
            await containerClient.CreateIfNotExistsAsync(PublicAccessType.None);

            // Compose the blob name like: quizId/questionId/filename.ext
            var fileName = Path.GetFileName(file.FileName);
            var blobName = $"{institutionId}/{fileName}";

            var blobClient = containerClient.GetBlobClient(blobName);

            using var stream = file.OpenReadStream();
            await blobClient.UploadAsync(stream, overwrite: true);

            return blobClient.Uri.ToString(); // Save this in your DB
        }

        public string GetAccountSasToken(int hoursValid = 12)
        {
            var credential = new StorageSharedKeyCredential(_accountName, _accountKey);

            var sasBuilder = new AccountSasBuilder
            {
                Services = AccountSasServices.Blobs,
                ResourceTypes = AccountSasResourceTypes.Container | AccountSasResourceTypes.Object,
                ExpiresOn = DateTimeOffset.UtcNow.AddHours(hoursValid),
                Protocol = SasProtocol.Https
            };

            sasBuilder.SetPermissions(AccountSasPermissions.Read | AccountSasPermissions.List);

            var sasToken = sasBuilder.ToSasQueryParameters(credential).ToString();

            return sasToken;
        }

        public async Task<bool> DeleteFileAsync(string url)
        {
            var credential = new StorageSharedKeyCredential(_accountName, _accountKey);

            var blobClient = new BlobClient(new Uri(url), credential);

            return await blobClient.DeleteIfExistsAsync();
        }
    }
}

package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestTerraformTags(t *testing.T) {
	awsRegion := "us-east-1"
	expectedName := "Flugel"
	expectedOwner := "InfraTeam"

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../infrastructure",
		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{},

		// Variables to pass to our Terraform code using -var-file options
		VarFiles: []string{"../infrastructure/terraform.tfvars"},

		// Disable colors in Terraform commands so its easier to parse stdout/stderr
		NoColor: true,
	})

	// clean resources
	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	// get ec2 instance.id
	instanceID := terraform.Output(t, terraformOptions, "ec2_id")

	// get s3 bucket.id
	bucketID := terraform.Output(t, terraformOptions, "s3_id")

	// Look up the tags for the given Instance ID
	instanceTags := aws.GetTagsForEc2Instance(t, awsRegion, instanceID)

	// Look up the tags for the given bucket ID
	bucketTags := aws.GetS3BucketTags(t, awsRegion, bucketID)

	// Test tags of EC2 instance
	nameTag_instance, containsNameTag_instance := instanceTags["Name"]
	assert.True(t, containsNameTag_instance)
	assert.Equal(t, expectedName, nameTag_instance)

	ownerTag_instance, containsOwnerTag_instance := instanceTags["Owner"]
	assert.True(t, containsOwnerTag_instance)
	assert.Equal(t, expectedOwner, ownerTag_instance)

	// Test tags of S3 Bucket
	nameTag_bucket, containsNameTag_bucket := bucketTags["Name"]
	assert.True(t, containsNameTag_bucket)
	assert.Equal(t, expectedName, nameTag_bucket)

	ownerTag_bucket, containsOwnerTag_bucket := bucketTags["Owner"]
	assert.True(t, containsOwnerTag_bucket)
	assert.Equal(t, expectedOwner, ownerTag_bucket)
}

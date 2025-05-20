// Copyright (c) Microsoft Corporation
// SPDX-License-Identifier: MPL-2.0

package terratests_test

import (
	"testing"

	"github.com/Azure/azure-sdk-for-go/sdk/azidentity"
	"github.com/gruntwork-io/terratest/modules/terraform"
	fabcore "github.com/microsoft/fabric-sdk-go/fabric/core"
	"github.com/stretchr/testify/assert"
)

func TestTerraform_Workspace(t *testing.T) {
	t.Parallel()

	expectedWorkspaceName := "test-workspace"
	expectedWorkspaceDescription := "test-workspace-description"
	expectedRoleAssignmentPrincipalID := "bb978eea-7929-4d11-86e5-4c50a643e510"

	// Configure Terraform setting up a path to Terraform code.
	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "./../301-testing-terraform",
		Vars: map[string]any{
			"workspace_name": expectedWorkspaceName,
			"principal": map[string]any{
				"id":   expectedRoleAssignmentPrincipalID,
				"type": "ServicePrincipal",
			},
			"workspace_description": expectedWorkspaceDescription,
		},
		Reconfigure: true,
	}

	// Defer 'terraform Destroy'
	defer terraform.Destroy(t, terraformOptions)

	// Run `terraform Init` to initialize Terraform and download the Terraform Provider for Fabric
	terraform.Init(t, terraformOptions)

	// Run `terraform Apply` to deploy resources.
	terraform.Apply(t, terraformOptions)

	// Run `terraform output` to read the expected values out of the terraform.tfstate output
	expectedWorkspaceID := terraform.Output(t, terraformOptions, "workspace_id")
	expectedWorkspaceRoleAssignmentID := terraform.Output(t, terraformOptions, "workspace_role_assignment_id")

	// Get actual values from the SDK
	credentials, _ := azidentity.NewDefaultAzureCredential(&azidentity.DefaultAzureCredentialOptions{})
	client, _ := fabcore.NewClientFactory(credentials, nil, nil)

	workspaceClient := client.NewWorkspacesClient()

	actualWorkspace, _ := workspaceClient.GetWorkspace(t.Context(), expectedWorkspaceID, nil)
	actualWorkspaceRoleAssignment, _ := workspaceClient.GetWorkspaceRoleAssignment(t.Context(), expectedWorkspaceID, expectedWorkspaceRoleAssignmentID, nil)

	// Assert workspace values
	assert.Equal(t, expectedWorkspaceName, *actualWorkspace.DisplayName, "workspace display_name was not assigned correctly")
	assert.Equal(t, expectedWorkspaceDescription, *actualWorkspace.Description, "workspace description was not assigned correctly")

	// Assert workspace role assignment values
	assert.Equal(t, expectedWorkspaceRoleAssignmentID, *actualWorkspaceRoleAssignment.ID, "workspace role was not assigned correctly")
}

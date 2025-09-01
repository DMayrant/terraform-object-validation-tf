# precondition:
you cannot reference data within the resource block with preconditions. 
allows you to check the validity of the resource configuration


    lifecycle {
      precondition {  
        condition    = contains(local.allowed_instance_types, var.instance_type)
        error_message = "Invalid instance type"

      }
    }

# postcondition:
 you can reference data within the resource block with postconditions. 
 allows you to check the validity of the resource configuration


    lifecycle {
        postcondition {  
          condition     = self.instance_type == "t2.micro" 
          error_message = "Invalid instance type"

      }
    }

Set your instances to be created before destroy to avoid system downtime:

    create_before_destroy = true 

# Check assertions: 
Checks to see what attributes are in your resources

    check "cost_center_check" {
      assert {
        condition     = can(aws_instance.this.tags.CostCenter != "")
        error_message = "Your AWS instance does not have a CostCenter"
      }
    }

Check assertions will issue you a warning attribute you're checking for isn't available. 
Check assertions should not be used for critical validation configuration. 
they are good to use if you're deploying subnets across multiple AZ's for fault tolerance 

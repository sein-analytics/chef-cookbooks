default.smartstack.services.mysql = {
	'synapse' => {
	  'discovery' => { 
	  	'method' => 'ec2tag',
	  	'tag_name' => 'opsworks:layer:mysql',
	  	'tag_value' => 'MySQL',
	  	'aws_access_key_id' => 'AKIAJVFAK5A4QL5WABIA',
	  	'aws_secret_access_key' => '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',
	  	'aws_region' => 'us-east-1'
	  },
	  'haproxy' => {
	    'server_options' => 'check inter 1s rise 1 fall 1',
	    'listen' => [
	      'mode tcp'
	    ]
	  },
	}
}

default.synapse.enabled_services = ['mysql']
require 'yaml'

NODE = {
  "cwb" => {
    "server" => "localhost",
    "repetitions" => 1,
    "metrics" => [ "cpu_model_name" ]
  },
  "sysbench" => {
    "commands" => [ "sysbench --test=cpu --max-prime-number=20000 run",
                    "sysbench --test=io run",
                  ]
  }
}
File.write('./node.yml', NODE.to_yaml)

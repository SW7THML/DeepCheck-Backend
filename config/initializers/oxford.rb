keys = YAML.load_file(Rails.root.join("config/ms.yml"))[Rails.env]
oxford_api_key = keys["oxford_api_key"]
PhotosHelper::MSCognitive.init(oxford_api_key)

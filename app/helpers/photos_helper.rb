require 'uri'
require 'net/http'
require 'openssl'

keys = YAML.load_file(Rails.root.join("config/ms.yml"))[Rails.env]
KEY = keys["oxford_api_key"]

module PhotosHelper
  class HttpClient
    def initialize(api_key, ms = false)
      #uris = URI.parse("http://localhost:3000")
      if ms
        uris = URI.parse("https://api.projectoxford.ai")
        @http = Net::HTTP.new(uris.host, uris.port)
        @http.use_ssl = true
        @http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      else
        uris = URI.parse("http://127.0.0.1:4000")
        @http = Net::HTTP.new(uris.host, uris.port)
      end
      @api_key = api_key
    end

    def get(path, params = {})
      request = Net::HTTP::Get.new("/face/v1.0#{path}")
      #request['Content-Type'] = "application/json"
      request.content_type = "application/json"
      #request['Connection'] = "Keep-Alive"
      request['Ocp-Apim-Subscription-Key'] = @api_key
      if params.is_a?(Hash)
        request.set_form_data(params)
      else
        request.body = params
      end
      response = @http.request(request)
      puts response.body
      response
    end

    def post(path, params = {})
      request = Net::HTTP::Post.new("/face/v1.0#{path}")
      #request['Content-Type'] = "application/json"
      request.content_type = "application/json"
      #request['Connection'] = "Keep-Alive"
      request['Ocp-Apim-Subscription-Key'] = @api_key
      if params.is_a?(Hash)
        #request.set_form_data(params)
        request.body = params.to_json
      else
        request.body = params
      end
      response = @http.request(request)
      puts response.body
      response
    end

    def put(path, params = {})
      request = Net::HTTP::Put.new("/face/v1.0#{path}")
      #request['Content-Type'] = "application/json"
      request.content_type = "application/json"
      #request['Connection'] = "Keep-Alive"
      request['Ocp-Apim-Subscription-Key'] = @api_key
      if params.is_a?(Hash)
        #request.set_form_data(params)
        request.body = params.to_json
      else
        request.body = params
      end
      response = @http.request(request)
      puts response.body
      response
    end

    def patch(path, params = {})
      request = Net::HTTP::Patch.new("/face/v1.0#{path}")
      #request['Content-Type'] = "application/json"
      request.content_type = "application/json"
      #request['Connection'] = "Keep-Alive"
      request['Ocp-Apim-Subscription-Key'] = @api_key
      if params.is_a?(Hash)
        #request.set_form_data(params)
        request.body = params.to_json
      else
        request.body = params
      end
      response = @http.request(request)
      puts response.body
      response
    end

    def delete(path, params = {})
      request = Net::HTTP::Delete.new("/face/v1.0#{path}")
      #request['Content-Type'] = "application/json"
      request.content_type = "application/json"
      #request['Connection'] = "Keep-Alive"
      request['Ocp-Apim-Subscription-Key'] = @api_key
      if params.is_a?(Hash)
        request.set_form_data(params)
      else
        request.body = params
      end
      response = @http.request(request)
      puts response.body
      response
    end
  end

  module MSCognitive
    @api_key = KEY # required
    def self.init(api_key)
      @api_key = api_key
    end

    def self.API_KEY
      @api_key
    end

    class Face
      def initialize
        raise if MSCognitive.API_KEY.blank?
        @client = HttpClient.new(MSCognitive.API_KEY)
      end

      # Detect
      # POST https://api.projectoxford.ai/face/v1.0/detect[?returnFaceId][&returnFaceLandmarks][&returnFaceAttributes]
      def detect(url, return_face_id = true, return_face_landmarks = false, return_face_attributes = "")
        params = {
          url: url
        }
        @client.post("/detect?returnFaceId=#{return_face_id}&returnFaceLandmarks=#{return_face_landmarks}&returnFaceAttributes=#{return_face_attributes}", params)
      end

      # TODO
      # Find Similar
      # POST https://api.projectoxford.ai/face/v1.0/findsimilars
      def find_similar
        params = {
        }
        @client.post("/findsimilars", params)
      end

      # TODO
      # Group
      # POST https://api.projectoxford.ai/face/v1.0/group
      def group
        params = {
        }
        @client.post("/group", params)
      end

      # Identify
      # POST https://api.projectoxford.ai/face/v1.0/identify
      def identify(group_id, face_ids, max_num_of_candidates_returned = 1, confidence_threshold = 0.5)
        params = {
          faceIds: face_ids,
          personGroupId: group_id, 
          maxNumOfCandidatesReturned: max_num_of_candidates_returned,
          confidenceThreshold: confidence_threshold
        }
        @client.post("/identify", params)
      end

      # Verify
      # POST https://api.projectoxford.ai/face/v1.0/verify
      def verify(face_id, group_id, person_id = "")
        if person_id.blank?
          face_id1 = face_id
          face_id2 = group_id

          params = {
            faceId1: face_id1,
            faceId2: face_id2,
          }
        else
          params = {
            faceId: face_id,
            personGroupId: group_id,
            personId: person_id
          }
        end
        @client.post("/verify", params)
      end
    end

    class FaceList
      def initialize
        raise if MSCognitive.API_KEY.blank?
        @client = HttpClient.new(MSCognitive.API_KEY)
      end

      # Add a Face to a Face List
      # POST https://api.projectoxford.ai/face/v1.0/facelists/{faceListId}/persistedFaces[?userData][&targetFace]
      def add_face(face_list_id, url, user_data = "", target_face = "")
        params = {
          url: url
        }
        @client.post("/facelists/#{face_list_id}/persistedFaces?userData=#{user_data}&targetFace=#{target_face}", params)
      end

      # Create a Face List
      # PUT https://api.projectoxford.ai/face/v1.0/facelists/{faceListId}
      def create(face_list_id, name, user_data = "")
        params = {
          name: name,
          userData: user_data
        }
        @client.put("/facelists/#{face_list_id}", params)
      end

      # FIXME
      # Delete a Face from a Face List
      # DELETE https://api.projectoxford.ai/face/v1.0/facelists/{faceListId}/persistedFaces/{persistedFaceId}
      def delete_face(face_list_id, face_id)
        @client.delete("/facelists/#{face_list_id}/persistedFaces/#{face_id}")
      end

      # FIXME
      # Delete a Face List
      # DELETE https://api.projectoxford.ai/face/v1.0/facelists/{faceListId}
      def delete(face_list_id)
        @client.delete("/facelists/#{face_list_id}")
      end

      # Get a Face List
      # GET https://api.projectoxford.ai/face/v1.0/facelists/{faceListId}
      def faces(face_list_id)
        @client.get("/facelists/#{face_list_id}")
      end

      # List Face Lists
      # GET https://api.projectoxford.ai/face/v1.0/facelists
      def all
        @client.get("/facelists")
      end

      # Update a Face List
      # PATCH https://api.projectoxford.ai/face/v1.0/facelists/{faceListId}
      def update(face_list_id, name, user_data)
        params = {
          name: name,
          userData: user_data
        }
        @client.patch("/facelists/#{face_list_id}", params)
      end
    end

    class Person
      def initialize
        raise if MSCognitive.API_KEY.blank?
        @client = HttpClient.new(MSCognitive.API_KEY)
      end

      # Add a Person Face
      # POST https://api.projectoxford.ai/face/v1.0/persongroups/{personGroupId}/persons/{personId}/persistedFaces[?userData][&targetFace]
      def add_face(group_id, person_id, url, user_data = "", target_face = "")
        params = {
          url: url
        }
        @client.post("/persongroups/#{group_id}/persons/#{person_id}/persistedFaces?userData=#{user_data}&targetFace=#{target_face}", params)
      end

      # Create a Person
      # POST https://api.projectoxford.ai/face/v1.0/persongroups/{personGroupId}/persons
      def create(group_id, name, user_data = "")
        params = {
          name: name,
          userData: user_data
        }
        @client.post("/persongroups/#{group_id}/persons", params)
      end

      # FIXME
      # Delete a Person
      # DELETE https://api.projectoxford.ai/face/v1.0/persongroups/{personGroupId}/persons/{personId}
      def delete(group_id, person_id)
        @client.delete("/persongroups/#{group_id}/persons/#{person_id}")
      end

      # FIXME
      # Delete a Person Face
      # DELETE https://api.projectoxford.ai/face/v1.0/persongroups/{personGroupId}/persons/{personId}/persistedFaces/{persistedFaceId}
      def delete_face(group_id, person_id, face_id)
        @client.delete("/persongroups/#{group_id}/persons/#{person_id}/persistedFaces/#{face_id}")
      end

      # Get a Person
      # GET https://api.projectoxford.ai/face/v1.0/persongroups/{personGroupId}/persons/{personId}
      def get(group_id, person_id)
        @client.get("/persongroups/#{group_id}/persons/#{person_id}")
      end

      # Get a Person Face
      # GET https://api.projectoxford.ai/face/v1.0/persongroups/{personGroupId}/persons/{personId}/persistedFaces/{persistedFaceId}
      def face(group_id, person_id, face_id)
        @client.get("/persongroups/#{group_id}/persons/#{person_id}/persistedFaces/#{face_id}")
      end

      # List Persons in a Person Group
      # GET https://api.projectoxford.ai/face/v1.0/persongroups/{personGroupId}/persons
      def all(group_id)
        @client.get("/persongroups/#{group_id}/persons")
      end

      # Update a Person
      # PATCH https://api.projectoxford.ai/face/v1.0/persongroups/{personGroupId}/persons/{personId}
      def update(group_id, person_id, name, user_data)
        params = {
          name: name,
          userData: user_data
        }
        @client.patch("/persongroups/#{group_id}/persons/#{person_id}", params)
      end

      # Update a Person Face
      # PATCH ttps://api.projectoxford.ai/face/v1.0/persongroups/{personGroupId}/persons/{personId}/persistedFaces/{persistedFaceId}
      def update_face(group_id, person_id, face_id, user_data)
        params = {
          userData: user_data
        }
        @client.patch("/persongroups/#{group_id}/persons/#{person_id}/persistedFaces/#{face_id}", params)
      end
    end

    class PersonGroup
      def initialize
        raise if MSCognitive.API_KEY.blank?
        @client = HttpClient.new(MSCognitive.API_KEY)
      end

      # Create a Person Group
      # PUT https://api.projectoxford.ai/face/v1.0/persongroups/{personGroupId}
      def create(group_id, name, user_data = "")
        params = {
          name: name,
          userData: user_data
        }
        @client.put("/persongroups/#{group_id}", params)
      end

      # FIXME
      # Delete a Person Group
      # DELETE https://api.projectoxford.ai/face/v1.0/persongroups/{personGroupId}
      def delete(group_id)
        @client.delete("/persongroups/#{group_id}")
      end

      # Get a Person Group
      # GET https://api.projectoxford.ai/face/v1.0/persongroups/{personGroupId}
      def get(group_id)
        @client.get("/persongroups/#{group_id}")
      end

      # Get Person Group Training Status
      # GET https://api.projectoxford.ai/face/v1.0/persongroups/{personGroupId}/training
      def status(group_id)
        @client.get("/persongroups/#{group_id}/training")
      end

      # List Person Groups
      # GET https://api.projectoxford.ai/face/v1.0/persongroups[?start][&top]
      def all(start = 1, top = 1000)
        @client.get("/persongroups?start=#{start}&top=#{top}")
      end

      # Train Person Group
      # POST https://api.projectoxford.ai/face/v1.0/persongroups/{personGroupId}/train
      def train(group_id)
        @client.post("/persongroups/#{group_id}/train")
      end

      # Update a Person Group
      # PATCH https://api.projectoxford.ai/face/v1.0/persongroups/{personGroupId}
      def update(group_id, name, user_data)
        params = {
          name: name,
          userData: user_data
        }
        @client.patch("/persongroups/#{group_id}", params)
      end
    end
  end
end

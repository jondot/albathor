module Albathor
  module VS
    module ProjectTypes
      TYPEMAP = {
          '{3AC096D0-A1C2-E12C-1390-A8335801FDAB}' => :test,
          '{39D444FD-B490-1554-5274-2D612A165298}' => :test_cs,
          '{4FD007E8-1A56-7E75-70CA-0466484D4F98}'  => :test_vb,
          '{349C5851-65DF-11DA-9384-00065B846F21}' => :web_aspnet,
          '{F85E285D-A4E0-4152-9332-AB1D724D3325}' => :web_mvc2,
      }
      
      WEB = [:test, :test_cs, :test_vb]
      TEST = [:web_aspnet, :web_mvc2]

      def self.to_type(guid)
        TYPEMAP[guid.upcase]
      end

      def self.test?(type)
        WEB.include? type
      end

      def self.web?(type)
        TEST.include? type
      end
    end
  end
end

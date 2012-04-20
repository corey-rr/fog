Shindo.tests('Fog::Compute[:xenserver] | VIF model', ['VIF']) do

  vifs = Fog::Compute[:xenserver].vifs
  vif = vifs.first

  tests('The VIF model should') do
    tests('have the action') do
      test('reload save destroy network server') { vif.respond_to? 'reload' }
    end
    tests('have attributes') do
      model_attribute_hash = vif.attributes
      attributes = [ 
        :reference,
        :mac,
        :uuid,
        :allowed_operations,
        :currently_attached,
        :device,
        :mac_autogenerated,
        :metrics,
        :mtu,
        :__network,
        :status_code,
        :status_detail,
        :__vm
      ]
      tests("The VIF model should respond to") do
        attributes.each do |attribute|
          test("#{attribute}") { vif.respond_to? attribute }
        end
      end
      tests("The attributes hash should have key") do
        attributes.each do |attribute|
          test("#{attribute}") { model_attribute_hash.has_key? attribute }
        end
      end
    end

    test('be a kind of Fog::Compute::XenServer::VIF') { vif.kind_of? Fog::Compute::XenServer::VIF}

  end

  tests("A real VIF should") do
    tests("return a valid network") do
      test("should be a Fog::Compute::XenServer::Network") { vif.network.kind_of? Fog::Compute::XenServer::Network }
    end
    tests("return valid VIF") do
      test("should be a Fog::Compute::XenServer::Server") { vif.server.kind_of? Fog::Compute::XenServer::Server }
    end

  end

end
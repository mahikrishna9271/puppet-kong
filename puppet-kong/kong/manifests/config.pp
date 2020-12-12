class kong::config inherits kong::param {



file {  "/etc/puppetlabs/code/environments/production/modules/kong/templates/${tag_name}.json.erb":
          ensure => present,
          source => "$template_path",
}
tidy { "/etc/${tag_name}.json" : }

file { "/etc/${tag_name}.json" :
          ensure  => file,
          content => template("kong/${tag_name}.json.erb"),
          owner  => 'root',
          group  => 'wheel',
          mode   => '0750',
      }


}

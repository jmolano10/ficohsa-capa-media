xquery version "1.0" encoding "utf-8";
(:: OracleAnnotationVersion "1.0" ::)
declare variable $countryCode as xs:string external;
declare variable $senseConversion as xs:string external;

declare function local:getXMLCountries()
    as element(*){
    	<CountryCodes>
           <ConversionType type="ISO3">
              <CountryCode osb="GT01">GTM</CountryCode>
              <CountryCode osb="HN01">HND</CountryCode>
              <CountryCode osb="NI01">NIC</CountryCode>
              <CountryCode osb="PA01">PAN</CountryCode>
              </ConversionType>
              <ConversionType type="ISO2">
              <CountryCode osb="GT01">GT</CountryCode>
              <CountryCode osb="HN01">HN</CountryCode>
              <CountryCode osb="NI01">NI</CountryCode>
              <CountryCode osb="PA01">PA</CountryCode>
            </ConversionType>
        </CountryCodes>
    };

declare function local:funcconvertCountry($countryCode as xs:string, 
                                          $senseConversion as xs:string) {
 
     if(upper-case($senseConversion) = 'OSB-IS03')then(
        let $equivalentCode := data(local:getXMLCountries()/ConversionType[@type='ISO3']/CountryCode[@osb=$countryCode]/text())
           return
            if( $equivalentCode != '')then(
                $equivalentCode
             )else(
               $countryCode
             )                      
             )else if(upper-case($senseConversion) = 'OSB-IS02')then(
              let $equivalentCode := data(local:getXMLCountries()/ConversionType[@type='ISO2']/CountryCode[@osb=$countryCode]/text())
              return
                  if( $equivalentCode != '')then(
                      $equivalentCode
                  )else(
                    $countryCode
                  )
                                               
                  )else if (upper-case($senseConversion) = 'ISO2-OSB')then(
                    let $equivalentCode := data(local:getXMLCountries()/ConversionType[@type='ISO2']/CountryCode[text()=$countryCode]/@osb)
                        return
                          if( $equivalentCode != '')then(
                              $equivalentCode
                            )else(
                            $countryCode
                            )
                                                
                        )else if (upper-case($senseConversion) = 'ISO3-OSB')then(
                          let $equivalentCode := data(local:getXMLCountries()/ConversionType[@type='ISO3']/CountryCode[text()=$countryCode]/@osb)
                          return
                          if( $equivalentCode != '')then(
                              $equivalentCode
                           )else(
                            $countryCode
                          )                 
                        )else($countryCode)
};

local:funcconvertCountry($countryCode, $senseConversion)
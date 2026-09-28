xquery version "1.0" encoding "Cp1252";

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/Generales/xq/convertirCodigoPais/";

declare function obtenerXMLPaises()
    as element(*){
    	<COUNTRY_CODES>
		    <CONVERSION_TYPE tipo="ISO3">
		        <COUNTRY_CODE osb="GT01">GTM</COUNTRY_CODE>
		        <COUNTRY_CODE osb="HN01">HND</COUNTRY_CODE>
		        <COUNTRY_CODE osb="NI01">NIC</COUNTRY_CODE>
		        <COUNTRY_CODE osb="PA01">PAN</COUNTRY_CODE>
		    </CONVERSION_TYPE>
		    <CONVERSION_TYPE tipo="ISO2">
		        <COUNTRY_CODE osb="GT01">GT</COUNTRY_CODE>
		        <COUNTRY_CODE osb="HN01">HN</COUNTRY_CODE>
		        <COUNTRY_CODE osb="NI01">NI</COUNTRY_CODE>
		        <COUNTRY_CODE osb="PA01">PA</COUNTRY_CODE>
		    </CONVERSION_TYPE>
		</COUNTRY_CODES>
    };

declare function xf:convertirCodigoPais($codigoPais as xs:string,
    $sentidoConversion as xs:string)
    as xs:string {
		
			if(upper-case($sentidoConversion) = 'OSB-ISO3')then(		
					
				let $codEquivalente := string(obtenerXMLPaises()/CONVERSION_TYPE[ @tipo='ISO3' ]/COUNTRY_CODE[ @osb=$codigoPais ]/text())
				return
					if($codEquivalente != '')then(
						$codEquivalente
					)else(
						$codigoPais
					)
											
			)else if (upper-case($sentidoConversion) = 'OSB-ISO2')then(
			
				let $codEquivalente := string(obtenerXMLPaises()/CONVERSION_TYPE[ @tipo='ISO2' ]/COUNTRY_CODE[ @osb=$codigoPais ]/text())
				return
					if($codEquivalente != '')then(
						$codEquivalente
					)else(
						$codigoPais
					)
				
			)else if (upper-case($sentidoConversion) = 'ISO2-OSB')then(
			
				let $codEquivalente := string(obtenerXMLPaises()/CONVERSION_TYPE[ @tipo='ISO2' ]/COUNTRY_CODE[ text()=$codigoPais ]/@osb)
				return
					if($codEquivalente != '')then(
						$codEquivalente
					)else(
						$codigoPais
					)
			
			)else if (upper-case($sentidoConversion) = 'ISO3-OSB')then(
			
				let $codEquivalente := string(obtenerXMLPaises()/CONVERSION_TYPE[ @tipo='ISO3' ]/COUNTRY_CODE[ text()=$codigoPais ]/@osb)
				return
					if($codEquivalente != '')then(
						$codEquivalente
					)else(
						$codigoPais
					)
			
			)else($codigoPais)
};

declare variable $codigoPais as xs:string external;
declare variable $sentidoConversion as xs:string external;

xf:convertirCodigoPais($codigoPais,
    $sentidoConversion)
xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com/midleware.services/convertirCodigoPais";
declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare variable $codigoPais as xs:string external;
declare variable $sentidoConversion as xs:string external;

declare function xq:obtenerXMLPaises()
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

declare function ns1:convertirCodigoPais($codigoPais as xs:string, 
                                         $sentidoConversion as xs:string) 
                                         as xs:string {
			if(upper-case($sentidoConversion) = 'OSB-ISO3')then(		
					
				let $codEquivalente := string(xq:obtenerXMLPaises()/CONVERSION_TYPE[ @tipo='ISO3' ]/COUNTRY_CODE[ @osb=$codigoPais ]/text())
				return
					if($codEquivalente != '')then(
						$codEquivalente
					)else(
						$codigoPais
					)
											
			)else if (upper-case($sentidoConversion) = 'OSB-ISO2')then(
			
				let $codEquivalente := string(xq:obtenerXMLPaises()/CONVERSION_TYPE[ @tipo='ISO2' ]/COUNTRY_CODE[ @osb=$codigoPais ]/text())
				return
					if($codEquivalente != '')then(
						$codEquivalente
					)else(
						$codigoPais
					)
				
			)else if (upper-case($sentidoConversion) = 'ISO2-OSB')then(
			
				let $codEquivalente := string(xq:obtenerXMLPaises()/CONVERSION_TYPE[ @tipo='ISO2' ]/COUNTRY_CODE[ text()=$codigoPais ]/@osb)
				return
					if($codEquivalente != '')then(
						$codEquivalente
					)else(
						$codigoPais
					)
			
			)else if (upper-case($sentidoConversion) = 'ISO3-OSB')then(
			
				let $codEquivalente := string(xq:obtenerXMLPaises()/CONVERSION_TYPE[ @tipo='ISO3' ]/COUNTRY_CODE[ text()=$codigoPais ]/@osb)
				return
					if($codEquivalente != '')then(
						$codEquivalente
					)else(
						$codigoPais
					)
			
			)else($codigoPais)
};

ns1:convertirCodigoPais($codigoPais, $sentidoConversion)

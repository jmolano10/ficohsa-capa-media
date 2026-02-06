xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
(:: import schema at "../xsd/consultaClientesTypes.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/honduras/pension/cloudCodeTypes";
(:: import schema at "../../../../v2/BusinessServices/FPC/CloudCode/Schemas/CloudCodeTypes.xsd" ::)

declare variable $responseDemograficos as element() (:: schema-element(ns1:cuentasClientesDemograficosResponse) ::) external;
declare variable $responseLaborales as element() (:: schema-element(ns1:clientesLaboralesResponse) ::) external;
declare variable $responsePreferidos as element() (:: schema-element(ns1:clientesLocalizadoresPreferidosResponse) ::) external;

declare function local:format-date-from-FPC($textdate as xs:string?, $format as xs:string) as xs:string
{
  if(fn:exists($textdate) and fn-bea:trim($textdate) != "") then (
	fn-bea:date-to-string-with-format(
        "yyyyMMddHHmmss",
        fn-bea:date-from-string-with-format($format, $textdate)
        )
        )else("")
};

declare function local:obtenerXMLDocumentos()
    as element(*){
    	<LEGAL_ID_TYPES>
              <LEGAL_ID_TYPE name="CC">1</LEGAL_ID_TYPE>
              <LEGAL_ID_TYPE name="NIT">9</LEGAL_ID_TYPE>
              <LEGAL_ID_TYPE name="PAS">4</LEGAL_ID_TYPE>
              <LEGAL_ID_TYPE name="CAR">2</LEGAL_ID_TYPE>
        </LEGAL_ID_TYPES>
    };

declare function local:func($responseDemograficos as element() (:: schema-element(ns1:cuentasClientesDemograficosResponse) ::), 
                            $responseLaborales as element() (:: schema-element(ns1:clientesLaboralesResponse) ::), 
                            $responsePreferidos as element() (:: schema-element(ns1:clientesLocalizadoresPreferidosResponse) ::)) 
                            as element() (:: schema-element(ns2:consultaClienteResponse) ::) {
    <ns2:consultaClienteResponse>
	            <ns2:IDENTIFICATION_INFO>
				    {
                       for $item in $responseDemograficos/ns1:datos/ns1:demograficos/ns1:persona
                       return
	                <ns2:LEGAL_IDENTIFICATION_ITEM>
	                    <ns2:LEGAL_DOCUMENT_NAME>{ string(local:obtenerXMLDocumentos()/LEGAL_ID_TYPE[ @name=upper-case(data($item/ns1:tipoIdentificacion)) ]/text())}</ns2:LEGAL_DOCUMENT_NAME>
	                    <ns2:LEGAL_ID>{fn:replace(string($item/ns1:identificacion),'^(\d{4})(\d{4})(\d{5})$', '$1-$2-$3')}</ns2:LEGAL_ID>
                            <ns2:EXPIRATION_DATE>{ local:format-date-from-FPC(fn:string($item/ns1:fechaVencimiento/text()),"yyyy-MM-ddXXX") }</ns2:EXPIRATION_DATE>
	                </ns2:LEGAL_IDENTIFICATION_ITEM>
					}
	            </ns2:IDENTIFICATION_INFO>
        <ns2:FULL_NAME>{
          fn-bea:trim(
            fn:concat(
              fn:data($responseDemograficos/ns1:datos/ns1:demograficos/ns1:persona/ns1:primerNombre),
              ' ',
              fn:data($responseDemograficos/ns1:datos/ns1:demograficos/ns1:persona/ns1:segundoNombre),
              ' ',
              fn:data($responseDemograficos/ns1:datos/ns1:demograficos/ns1:persona/ns1:primerApellido),
              ' ',
              fn:data($responseDemograficos/ns1:datos/ns1:demograficos/ns1:persona/ns1:segundoApellido)
            )
          )
        }</ns2:FULL_NAME>
        <ns2:DATE_OF_BIRTH>{ local:format-date-from-FPC(fn:string($responseDemograficos/ns1:datos/ns1:demograficos/ns1:persona/ns1:fechaNacimiento/text()),"yyyy-MM-ddXXX") }</ns2:DATE_OF_BIRTH>
        <ns2:PHONE_INFO>
	            {
                      
              for $itemHome in $responsePreferidos/ns1:datos/ns1:localizadores/ns1:residencial
              return(
                            <ns2:PHONE_NUMBER_ITEM> 
                                <ns2:PHONE_LOCATION>HOME</ns2:PHONE_LOCATION>
                                <ns2:PHONE_TYPE>{fn:data($itemHome/ns1:tipoLocalizador)}</ns2:PHONE_TYPE>
                                <ns2:PHONE_AREA_CODE>{ data($itemHome/ns1:codigoAreaCelular) }</ns2:PHONE_AREA_CODE>
                                <ns2:PHONE_NUMBER>{data($itemHome/ns1:numeroCelular)}</ns2:PHONE_NUMBER>
                                <ns2:IS_DEFAULT>YES</ns2:IS_DEFAULT>
                            </ns2:PHONE_NUMBER_ITEM>
              )						
	            }
        </ns2:PHONE_INFO>
        <ns2:ADDRESS_INFO>
    {                   
	            	for $AddressItemHome in $responsePreferidos/ns1:datos/ns1:localizadores/ns1:residencial
		            return(
			               <ns2:ADDRESS_ITEM>
							    <ns2:ADDRESS_CODE>{ data($AddressItemHome/ns1:codigoUbicacion) }</ns2:ADDRESS_CODE>
			            		<ns2:ADDRESS_TYPE>HOME</ns2:ADDRESS_TYPE>
			            		<ns2:POBOX/>
                                <ns2:ZIPCODE/>			            		
			                	<ns2:COUNTRY_CODE>{data($AddressItemHome/ns1:codigoPais) }</ns2:COUNTRY_CODE>
			                	<ns2:DEPARTMENT_CODE>{data($AddressItemHome/ns1:codigoDepartamento) }</ns2:DEPARTMENT_CODE>
								<ns2:MUNICIPALITY_CODE>{ data($AddressItemHome/ns1:codigoMunicipio) }</ns2:MUNICIPALITY_CODE>
                                <ns2:CITY_CODE>{data($AddressItemHome/ns1:codigoColinia) }</ns2:CITY_CODE>
                                <ns2:DISTRICT_CODE/>
                                <ns2:ADDRESS_LINE_1/>
                                <ns2:ADDRESS_LINE_2/>
                                <ns2:ADDRESS_LINE_3/>
                                <ns2:ADDRESS_LINE_4/>                                
                                <ns2:ADDRESS_LINE_5>{ data($AddressItemHome/ns1:direccionFisica) }</ns2:ADDRESS_LINE_5>
			                	<ns2:IS_MAIN_ADDRESS>YES</ns2:IS_MAIN_ADDRESS>
			                	<ns2:COUNTRY_DESC>{data($AddressItemHome/ns1:nombrePais) }</ns2:COUNTRY_DESC>
			                	<ns2:DEPARTMENT_DESC>{data($AddressItemHome/ns1:nombreDepartamento) }</ns2:DEPARTMENT_DESC>
			                	<ns2:MUNICIPALITY_DESC>{data($AddressItemHome/ns1:nombreMunicipio) }</ns2:MUNICIPALITY_DESC>
			                	<ns2:CITY_DESC>{data($AddressItemHome/ns1:nombreColonia) }</ns2:CITY_DESC>			                	
			                </ns2:ADDRESS_ITEM>
                              )
            }
			{
              for $AddressItemWork in $responsePreferidos/ns1:datos/ns1:localizadores/ns1:laboral
              return(
			               <ns2:ADDRESS_ITEM>
							    <ns2:ADDRESS_CODE>{ data($AddressItemWork/ns1:codigoUbicacion) }</ns2:ADDRESS_CODE>
			            		<ns2:ADDRESS_TYPE>WORK</ns2:ADDRESS_TYPE>
			            		<ns2:POBOX/>
                                <ns2:ZIPCODE/>
			                	<ns2:COUNTRY_CODE>{data($AddressItemWork/ns1:codigoPais) }</ns2:COUNTRY_CODE>
			                	<ns2:DEPARTMENT_CODE>{data($AddressItemWork/ns1:codigoDepartamento) }</ns2:DEPARTMENT_CODE>
								<ns2:MUNICIPALITY_CODE>{ data($AddressItemWork/ns1:codigoMunicipio) }</ns2:MUNICIPALITY_CODE>
                                <ns2:CITY_CODE>{data($AddressItemWork/ns1:codigoColinia) }</ns2:CITY_CODE>
                                <ns2:DISTRICT_CODE/>
                                <ns2:ADDRESS_LINE_1/>
                                <ns2:ADDRESS_LINE_2/>
                                <ns2:ADDRESS_LINE_3/>
                                <ns2:ADDRESS_LINE_4/>
                                <ns2:ADDRESS_LINE_5>{ data($AddressItemWork/ns1:direccionFisica) }</ns2:ADDRESS_LINE_5>
			                	<ns2:IS_MAIN_ADDRESS>YES</ns2:IS_MAIN_ADDRESS>
			                	<ns2:COUNTRY_DESC>{data($AddressItemWork/ns1:nombrePais) }</ns2:COUNTRY_DESC>
			                	<ns2:DEPARTMENT_DESC>{data($AddressItemWork/ns1:nombreDepartamento) }</ns2:DEPARTMENT_DESC>
			                	<ns2:MUNICIPALITY_DESC>{data($AddressItemWork/ns1:nombreMunicipio) }</ns2:MUNICIPALITY_DESC>
			                	<ns2:CITY_DESC>{data($AddressItemWork/ns1:nombreColonia) }</ns2:CITY_DESC>				                				                	
			                </ns2:ADDRESS_ITEM>
                   )							
		        }
        </ns2:ADDRESS_INFO>
        <ns2:EMAIL_INFO>
	            {
                      
              for $EmailItem in $responsePreferidos/ns1:datos/ns1:localizadores/ns1:residencial 
              return(
                      <ns2:EMAIL_ITEM>
                           <ns2:EMAIL_CODE>{ data($EmailItem/ns1:codigoCorreoElectronico)}</ns2:EMAIL_CODE>
                           <ns2:EMAIL_ADDRESS>{ data($EmailItem/ns1:correoElectronico)}</ns2:EMAIL_ADDRESS>
                           <ns2:IS_DEFAULT>YES</ns2:IS_DEFAULT>
                      </ns2:EMAIL_ITEM>
              )
	            }
        </ns2:EMAIL_INFO>
        <ns2:JOB_INFO>
            {
                for $JobItem in $responseLaborales/ns1:datos/ns1:laborales
                return(
	                <ns2:JOB_ITEM>
					    <ns2:EMPLOYER_CODE>{ data($JobItem/ns1:numeroIdentificacionEmpleador) }</ns2:EMPLOYER_CODE>
					    <ns2:EMPLOYER_NAME>{upper-case(fn:data($JobItem/ns1:razonSocial))}</ns2:EMPLOYER_NAME>
					    <ns2:JOB_CODE/>
	                    <ns2:JOB_DESCRIPTION>{ data($JobItem/ns1:cargo) }</ns2:JOB_DESCRIPTION>
						<ns2:INCOME_TYPE>SALARY</ns2:INCOME_TYPE>
						<ns2:SALARY_CURRENCY/>
	                    <ns2:SALARY_AMOUNT/>
	                    <ns2:START_DATE>{ local:format-date-from-FPC(fn:string($JobItem/ns1:fechaIngresoLabor/text()),"dd/MM/yyyy") }</ns2:START_DATE>
						<ns2:END_DATE/>
                    {
                      for $IsCurrentJob in $JobItem/ns1:empleoActual
                      return
                      if (fn:data(upper-case($IsCurrentJob)) = 'SI') then (
                        <ns2:IS_CURRENT_JOB>YES</ns2:IS_CURRENT_JOB>
                      ) else (
                        <ns2:IS_CURRENT_JOB>NO</ns2:IS_CURRENT_JOB>
                      )
                    }
	                </ns2:JOB_ITEM>
                )
			       }		
                   
        </ns2:JOB_INFO>    
    </ns2:consultaClienteResponse>
};

local:func($responseDemograficos, $responseLaborales, $responsePreferidos)
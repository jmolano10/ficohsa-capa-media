(:: pragma bea:global-element-parameter parameter="$opConsultaClienteInfoRespuesta" element="ns2:opConsultaClienteInfoRespuesta" location="../../../../v2/BusinessServices/CTS/cliente/xsd/services.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaClienteResponse" location="../xsd/consultaClientesTypes.xsd" ::)

declare namespace ns2 = "http://service.srvaplcobiscliente.ecobis.cobiscorp";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace ns0 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ConsultaCliente/xq/consultaClienteNIOut/";

(: Retorna el tipo de persona :)
declare function type-of-person 
  ( $sector as xs:string )  as xs:string {
  if (fn:string($sector) = "Natural") then (
  	"N"
  ) else (
  	"J"
  )
};

declare function xf:consultaClienteNIOut($opConsultaClienteInfoRespuesta as element(ns2:opConsultaClienteInfoRespuesta))
    as element(ns1:consultaClienteResponse) {
        let $cliente := $opConsultaClienteInfoRespuesta/ns0:cliente
        return
            <ns1:consultaClienteResponse>
                <ns1:CUSTOMER_ID>{ data($cliente/ns0:codCliente) }</ns1:CUSTOMER_ID>
                <ns1:IDENTIFICATION_INFO>
	                {
	                	let $personaJuridica := $cliente/ns0:persona/ns0:personaJuridica
                        return
	                	if (exists($personaJuridica/ns0:nombreDocLegal)) then (	
                            <ns1:LEGAL_IDENTIFICATION_ITEM>
                                <ns1:LEGAL_DOCUMENT_NAME>{ data($personaJuridica/ns0:nombreDocLegal) }</ns1:LEGAL_DOCUMENT_NAME>
                                <ns1:LEGAL_ID>{ data($personaJuridica/ns0:idLegal) }</ns1:LEGAL_ID>
                            </ns1:LEGAL_IDENTIFICATION_ITEM>	                    
	                    ) else (
	                    	<ns1:LEGAL_IDENTIFICATION_ITEM>
	                            <ns1:LEGAL_DOCUMENT_NAME></ns1:LEGAL_DOCUMENT_NAME>
	                            <ns1:LEGAL_ID></ns1:LEGAL_ID>
	                        </ns1:LEGAL_IDENTIFICATION_ITEM>
	                    )
                    }
                </ns1:IDENTIFICATION_INFO>
				<ns1:GIVEN_NAMES>{ data($cliente/ns0:nombres) }</ns1:GIVEN_NAMES>
                <ns1:FAMILY_NAME>{ data($cliente/ns0:apellidos) }</ns1:FAMILY_NAME>
                <ns1:FULL_NAME>{ data($cliente/ns0:nombreCompleto) }</ns1:FULL_NAME>
                <ns1:NAME_OF_BUSINESS>{ data($cliente/ns0:persona/ns0:personaJuridica/ns0:nombreDelNegocio) }</ns1:NAME_OF_BUSINESS>
                <ns1:LEGAL_HOLDER_NAME>{ data($cliente/ns0:nombreCompleto) }</ns1:LEGAL_HOLDER_NAME>
                <ns1:DATE_OF_BIRTH>
                	{ 
                		fn-bea:dateTime-to-string-with-format("yyyyMMdd", data($cliente/ns0:fecNacimiento)) 
            		}
        		</ns1:DATE_OF_BIRTH>
                <ns1:GENDER>{ data($cliente/ns0:persona/ns0:personaNatural/ns0:codSexo) }</ns1:GENDER>
                <ns1:NATIONALITY>{ data($cliente/ns0:persona/ns0:nacionalidad) }</ns1:NATIONALITY>
                <ns1:RESIDENCE>{ data($cliente/ns0:persona/ns0:direccion/ns0:ciudad/ns0:codCiudad) }</ns1:RESIDENCE>
                <ns1:MARITAL_STATUS>{ data($cliente/ns0:persona/ns0:codEstadoCivil) }</ns1:MARITAL_STATUS>
                <ns1:CUSTOMER_TYPE>{ data($cliente/ns0:valTipoCliente) }</ns1:CUSTOMER_TYPE>
                <ns1:EMPLOYMENT_STATUS>{ data($cliente/ns0:persona/ns0:personaNatural/ns0:estadoEmpleo) }</ns1:EMPLOYMENT_STATUS>
                <ns1:EMPLOYERS_NAME>{ data($cliente/ns0:persona/ns0:personaNatural/ns0:nombreEmpleador) }</ns1:EMPLOYERS_NAME>
                <ns1:MARRIED_LAST_NAME>{ data($cliente/ns0:persona/ns0:apellidoConyuge) }</ns1:MARRIED_LAST_NAME>
                <ns1:LEGAL_REP_NAME>{ data($cliente/ns0:persona/ns0:personaJuridica/ns0:nombreRepLegal) }</ns1:LEGAL_REP_NAME>
                <ns1:LEGAL_REP_ID>{ data($cliente/ns0:persona/ns0:personaJuridica/ns0:idRepLegal) }</ns1:LEGAL_REP_ID>
                <ns1:TYPE_OF_COMPANY>{ data($cliente/ns0:persona/ns0:personaJuridica/ns0:valTipoSociedad) }</ns1:TYPE_OF_COMPANY>
                <ns1:PROFESSION>{ data($cliente/ns0:persona/ns0:personaNatural/ns0:valProfesion) }</ns1:PROFESSION>
                <ns1:LEGAL_REP_HOME_PHONE>
                	{ data($cliente/ns0:persona/ns0:personaJuridica/ns0:telefonoCasaRepLegal) }
                </ns1:LEGAL_REP_HOME_PHONE>
                <ns1:TYPE_OF_PERSON>{ type-of-person(data($cliente/ns0:persona/ns0:valTipoPersona)) }</ns1:TYPE_OF_PERSON>
                <ns1:INPUT_USER>{ data($cliente/ns0:valIdCliente) }</ns1:INPUT_USER>
                <ns1:DATE_TIME>
                	{ 
                		fn-bea:dateTime-to-string-with-format("yyyyMMddHHmmss", data($cliente/ns0:fechaCreacion)) 
            		}
            	</ns1:DATE_TIME>
            	<ns1:BRANCH_CODE>{ data($cliente/ns0:oficina/ns0:codOficina) }</ns1:BRANCH_CODE>
                <ns1:NO_OF_DEPENDENTS>{ data($cliente/ns0:persona/ns0:nroDependientes) }</ns1:NO_OF_DEPENDENTS>
                <ns1:CUSTOMER_SINCE>
	                { 
	                	fn-bea:dateTime-to-string-with-format("yyyyMMdd", 
	                		fn-bea:dateTime-from-string-with-format("yyyy-MM-dd HH:mm:ss.S", 
	                			data($cliente/ns0:clienteDesde))) 
	    			}
    			</ns1:CUSTOMER_SINCE>
                <ns1:PHONE_INFO>
                    {
                        for $celular in $cliente/ns0:persona/ns0:celular
                        return
                            <ns1:PHONE_NUMBER_ITEM>
                                <ns1:PHONE_NUMBER>{ data($celular/ns0:valCelular) }</ns1:PHONE_NUMBER>
                            </ns1:PHONE_NUMBER_ITEM>
                    }
                    {
                        for $telefono in $cliente/ns0:persona/ns0:telefono
                        return
                            <ns1:PHONE_NUMBER_ITEM>
                                <ns1:PHONE_NUMBER>{ data($telefono/ns0:valTelefono) }</ns1:PHONE_NUMBER>
                            </ns1:PHONE_NUMBER_ITEM>
                    }
                </ns1:PHONE_INFO>
                <ns1:ADDRESS_INFO>
                    {
                        for $direccion in $opConsultaClienteInfoRespuesta/ns0:direccion
                        return
                            <ns1:ADDRESS_ITEM>
                                <ns1:ADDRESS_TYPE>{ data($direccion/ns0:codTipoDireccion) }</ns1:ADDRESS_TYPE>
                                <ns1:ZIPCODE>{ data($direccion/ns0:valCodigoPostal) }</ns1:ZIPCODE>
                                <ns1:COUNTRY_CODE>{ data($direccion/ns0:ciudad/ns0:pais/ns0:codPais) }</ns1:COUNTRY_CODE>
                                <ns1:DEPARTMENT_CODE>{ data($direccion/ns0:codDepartamento) }</ns1:DEPARTMENT_CODE>
                                <ns1:MUNICIPALITY_CODE>{ data($direccion/ns0:codMunicipio) }</ns1:MUNICIPALITY_CODE>
                                <ns1:CITY_CODE>{ data($direccion/ns0:ciudad/ns0:codCiudad) }</ns1:CITY_CODE>
                                <ns1:ADDRESS_LINE_1>{ data($direccion/ns0:valDireccion) }</ns1:ADDRESS_LINE_1>
                                <ns1:IS_MAIN_ADDRESS>
                                	{ 
                                    	if (fn:string(data($direccion/ns0:direccionPrincipalSiNo/text())) = "1") then (
                                        	"S"
										) else ( "N" )                                         
                                 	}
                        		</ns1:IS_MAIN_ADDRESS>
                            </ns1:ADDRESS_ITEM>
                    }
                </ns1:ADDRESS_INFO>
                <ns1:EMAIL_INFO>
                    <ns1:EMAIL_ITEM>
                        <ns1:EMAIL_ADDRESS>{ data($cliente/ns0:persona/ns0:email) }</ns1:EMAIL_ADDRESS>
                    </ns1:EMAIL_ITEM>
                </ns1:EMAIL_INFO>
            </ns1:consultaClienteResponse>
};

declare variable $opConsultaClienteInfoRespuesta as element(ns2:opConsultaClienteInfoRespuesta) external;

xf:consultaClienteNIOut($opConsultaClienteInfoRespuesta)
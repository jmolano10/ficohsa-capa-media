(:: pragma bea:global-element-parameter parameter="$consultaClienteResponse1" element="ns1:consultaClienteResponse" location="../../../../v3/BusinessServices/consultaCliente_v3/xsd/consultaClientesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaInfoClienteSlaResponse" location="../xsd/consultaInfoClienteSlaTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaInfoClienteSlaTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace xf = "http://tempuri.org/Middleware/External/Incoming/v2/Resources/ConsultaInfoClienteSLA/xq/consultaInfoClienteOut/";

declare function xf:consultaInfoClienteOut($consultaClienteResponse1 as element(ns1:consultaClienteResponse),
    $COLONY_CODE as xs:string)
    as element(ns0:consultaInfoClienteSlaResponse) {
        <ns0:consultaInfoClienteSlaResponse>
            <ns0:DNI>
                {
                    let $IDENTIFICATION_INFO := $consultaClienteResponse1/ns1:IDENTIFICATION_INFO
                    return
                        <ns0:LEGAL_IDENTIFICATION_ITEM>
                            <ns0:LEGAL_ID>{ data($IDENTIFICATION_INFO/ns1:LEGAL_IDENTIFICATION_ITEM[1]/ns1:LEGAL_ID) }</ns0:LEGAL_ID>
                        </ns0:LEGAL_IDENTIFICATION_ITEM>
                }
            </ns0:DNI>
            {
                for $GIVEN_NAMES in $consultaClienteResponse1/ns1:GIVEN_NAMES
                return
                    <ns0:FIRTS_NAME>{ data($GIVEN_NAMES) }</ns0:FIRTS_NAME>
            }
            {
                for $FAMILY_NAME in $consultaClienteResponse1/ns1:FAMILY_NAME
                return
                    <ns0:LAST_NAME>{ data($FAMILY_NAME) }</ns0:LAST_NAME>
            }
            {
                for $GENDER in $consultaClienteResponse1/ns1:GENDER
                return
                    <ns0:GENDER>{ data($GENDER) }</ns0:GENDER>
            }
            {
                	let $fechaActual := current-date()
				for $DATE_OF_BIRTH in $consultaClienteResponse1/ns1:DATE_OF_BIRTH
				let $nacimiento := xs:string(data($DATE_OF_BIRTH))

				let $añoNacimiento := xs:integer(fn:substring($nacimiento, 1, 4))
				let $mesNacimiento := xs:integer(fn:substring($nacimiento, 5, 2))
								
				let $añoActual := year-from-date($fechaActual)
				let $mesActual := month-from-date($fechaActual)
				let $edad := $añoActual - $añoNacimiento - (if ($mesActual < $mesNacimiento) then 1 else 0)
				
				return
    			<ns0:AGE>{ $edad }</ns0:AGE>
            }
            {
                for $EDUCATION_LEVEL in $consultaClienteResponse1/ns1:EDUCATION_LEVEL
                return
                    <ns0:EDUCATION_LEVEL>{ data($EDUCATION_LEVEL) }</ns0:EDUCATION_LEVEL>
            }
            {
            
            
              let $direccionPrincipal := $consultaClienteResponse1/ns1:ADDRESS_INFO/ns1:ADDRESS_ITEM[ns1:ADDRESS_TYPE = "1"]
              let $direccionSecundaria := $consultaClienteResponse1/ns1:ADDRESS_INFO/ns1:ADDRESS_ITEM[ns1:ADDRESS_TYPE = "2"]
              let $direccionAlternativa := $consultaClienteResponse1/ns1:ADDRESS_INFO/ns1:ADDRESS_ITEM[ns1:ADDRESS_TYPE = "3"]
              
              let $direccionSeleccionada :=
              if ($direccionPrincipal) then $direccionPrincipal
              else if ($direccionSecundaria) then $direccionSecundaria
              else $direccionAlternativa
              
              return
              <ns0:ADDRESS_INFO>
              <ns0:ADDRESS_ITEM>
              <ns0:ADDRESS_TYPE>{ data($direccionSeleccionada/ns1:ADDRESS_TYPE) }</ns0:ADDRESS_TYPE>
              <ns0:COUNTRY_CODE>{ data($direccionSeleccionada/ns1:COUNTRY_CODE) }</ns0:COUNTRY_CODE>
              <ns0:DEPARTMENT_CODE>{ data($direccionSeleccionada/ns1:DEPARTMENT_CODE) }</ns0:DEPARTMENT_CODE>
              <ns0:MUNICIPALITY_CODE>{ data($direccionSeleccionada/ns1:MUNICIPALITY_CODE) }</ns0:MUNICIPALITY_CODE>
              <ns0:CITY_CODE>{ data($direccionSeleccionada/ns1:CITY_CODE) }</ns0:CITY_CODE>
              <ns0:COLONY_CODE>{ data($direccionSeleccionada/ns1:COLONY_CODE) }</ns0:COLONY_CODE>
              <ns0:DISTRICT_CODE>{ data($direccionSeleccionada/ns1:DISTRICT_CODE) }</ns0:DISTRICT_CODE>
              <ns0:ADDRESS_LINE_1>{ data($direccionSeleccionada/ns1:ADDRESS_LINE_1) }</ns0:ADDRESS_LINE_1>
              <ns0:ADDRESS_LINE_2>{ data($direccionSeleccionada/ns1:ADDRESS_LINE_2) }</ns0:ADDRESS_LINE_2>
              <ns0:IS_MAIN_ADDRESS>{ data($direccionSeleccionada/ns1:IS_MAIN_ADDRESS) }</ns0:IS_MAIN_ADDRESS>
              </ns0:ADDRESS_ITEM>
              </ns0:ADDRESS_INFO>
            }
            {
                for $DATE_OF_BIRTH in $consultaClienteResponse1/ns1:DATE_OF_BIRTH
                return
                    <ns0:DATE_OF_BIRTH>{ data($DATE_OF_BIRTH) }</ns0:DATE_OF_BIRTH>
            }
            {
                for $PHONE_INFO in $consultaClienteResponse1/ns1:PHONE_INFO
                return
                    <ns0:PHONE_INFO>
                        {
                            for $PHONE_NUMBER_ITEM in $PHONE_INFO/ns1:PHONE_NUMBER_ITEM
                            return
                                <ns0:PHONE_NUMBER_ITEM>
                                    {
                                        for $PHONE_LOCATION in $PHONE_NUMBER_ITEM/ns1:PHONE_LOCATION
                                        return
                                            <ns0:PHONE_LOCATION>{ data($PHONE_LOCATION) }</ns0:PHONE_LOCATION>
                                    }
                                    {
                                        for $PHONE_TYPE in $PHONE_NUMBER_ITEM/ns1:PHONE_TYPE
                                        return
                                            <ns0:PHONE_TYPE>{ data($PHONE_TYPE) }</ns0:PHONE_TYPE>
                                    }
                                    {
                                        for $PHONE_AREA_CODE in $PHONE_NUMBER_ITEM/ns1:PHONE_AREA_CODE
                                        return
                                            <ns0:PHONE_AREA_CODE>{ data($PHONE_AREA_CODE) }</ns0:PHONE_AREA_CODE>
                                    }
                                    {
                                        for $PHONE_NUMBER in $PHONE_NUMBER_ITEM/ns1:PHONE_NUMBER
                                        return
                                            <ns0:PHONE_NUMBER>{ data($PHONE_NUMBER) }</ns0:PHONE_NUMBER>
                                    }
                                    {
                                        for $IS_DEFAULT in $PHONE_NUMBER_ITEM/ns1:IS_DEFAULT
                                        return
                                            <ns0:IS_DEFAULT>{ data($IS_DEFAULT) }</ns0:IS_DEFAULT>
                                    }
                                </ns0:PHONE_NUMBER_ITEM>
                        }
                    </ns0:PHONE_INFO>
            }
            {
                for $EMAIL_INFO in $consultaClienteResponse1/ns1:EMAIL_INFO
                return
                    <ns0:EMAIL_INFO>
                        {
                            for $EMAIL_ITEM in $EMAIL_INFO/ns1:EMAIL_ITEM
                            return
                                <ns0:EMAIL_ITEM>
                                    {
                                        for $EMAIL_CODE in $EMAIL_ITEM/ns1:EMAIL_CODE
                                        return
                                            <ns0:EMAIL_CODE>{ data($EMAIL_CODE) }</ns0:EMAIL_CODE>
                                    }
                                    {
                                        for $EMAIL_ADDRESS in $EMAIL_ITEM/ns1:EMAIL_ADDRESS
                                        return
                                            <ns0:EMAIL_ADDRESS>{ data($EMAIL_ADDRESS) }</ns0:EMAIL_ADDRESS>
                                    }
                                    {
                                        for $IS_DEFAULT in $EMAIL_ITEM/ns1:IS_DEFAULT
                                        return
                                            <ns0:IS_DEFAULT>{ data($IS_DEFAULT) }</ns0:IS_DEFAULT>
                                    }
                                </ns0:EMAIL_ITEM>
                        }
                    </ns0:EMAIL_INFO>
            }
        </ns0:consultaInfoClienteSlaResponse>
};

declare variable $consultaClienteResponse1 as element(ns1:consultaClienteResponse) external;
declare variable $COLONY_CODE as xs:string external;

xf:consultaInfoClienteOut($consultaClienteResponse1,
    $COLONY_CODE)
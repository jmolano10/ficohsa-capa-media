xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$registraDatosActualizados1" element="ns0:registraDatosActualizados" location="../../OperacionesDatosClientes/xsd/operacionesDatosClientesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ActualizaDatosGFF/RegistrarDatos/xsd/registrarDatos_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/operacionesDatosClientesTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registrarDatos";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RegistraDatosActualizados/xq/registrarDatosIn/";

declare function xf:registrarDatosIn($registraDatosActualizados1 as element(ns0:registraDatosActualizados), $countryId as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:P_CUSTOMER_ID>{ string($registraDatosActualizados1/CUSTOMER_DATA/CUSTOMER_INFO/INFO[NAME="CUSTOMER_ID"]/VALUE/text()) }</ns1:P_CUSTOMER_ID>
            <ns1:P_SOURCE_SYSTEM>{ string($registraDatosActualizados1/CUSTOMER_DATA/SYSTEM_INFO/INFO[NAME="SOURCE"]/VALUE/text()) }</ns1:P_SOURCE_SYSTEM>
            <ns1:P_COUNTRY_ID>{ $countryId }</ns1:P_COUNTRY_ID>
            {
            let $date :=  fn-bea:date-to-string-with-format("yyyy-MM-dd", fn-bea:date-from-string-with-format('ddMMyyyy',string($registraDatosActualizados1/CUSTOMER_DATA/CONTROL_INFO/INFO[NAME="CREATION_DATE"]/VALUE/text())))
            let $time :=  fn-bea:time-to-string-with-format('HH:mm:ss',fn-bea:time-from-string-with-format("HH:mm:ss",string($registraDatosActualizados1/CUSTOMER_DATA/CONTROL_INFO/INFO[NAME="UPDATE_TIME"]/VALUE/text())))
            return
                <ns1:P_OPERATION_DATE>{ fn-bea:dateTime-to-string-with-format("yyyy-MM-ddHH:mm:ss",fn-bea:dateTime-from-string-with-format("yyyy-MM-ddHH:mm:ss", string(concat($date,$time)))) }</ns1:P_OPERATION_DATE>
            }
            <ns1:P_OPERATION_TYPE>{ data($registraDatosActualizados1/OPERATION_TYPE) }</ns1:P_OPERATION_TYPE>
            {
            let $customerData := $registraDatosActualizados1/CUSTOMER_DATA
            return
            <ns1:P_REQUEST>{ fn-bea:serialize(
               <CUSTOMER_DATA>{  $customerData/CUSTOMER_INFO, $customerData/IDENTIFICATION_INFO,
	           	    for  $ADDRESS_INFO in $customerData/ADDRESS_INFO
	           	    return
	           	         $ADDRESS_INFO ,
	           	    for  $PHONE_INFO in $customerData/PHONE_INFO
	           	    return
	           	         $PHONE_INFO ,
	           	     for  $EMAIL_INFO in $customerData/EMAIL_INFO
	           	    return
	           	           $EMAIL_INFO,
	           	    $customerData/CONTROL_INFO,
	           	    $customerData/SYSTEM_INFO 
	           	           }</CUSTOMER_DATA>
	           	    ) }</ns1:P_REQUEST>
            }
            <ns1:P_STATUS_REQUEST>SUCCESS</ns1:P_STATUS_REQUEST>
            <ns1:P_FIELDS_BEFORE_MODIFY>{  fn-bea:serialize($registraDatosActualizados1/CUSTOMER_DATA/PREVIOUS_DATA_INFO) }</ns1:P_FIELDS_BEFORE_MODIFY>
        </ns1:InputParameters>
};

declare variable $registraDatosActualizados1 as element(ns0:registraDatosActualizados) external;
declare variable $countryId as xs:string external;

xf:registrarDatosIn($registraDatosActualizados1, $countryId)
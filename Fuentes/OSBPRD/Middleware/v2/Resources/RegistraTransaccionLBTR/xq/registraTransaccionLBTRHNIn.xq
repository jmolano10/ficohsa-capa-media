(:: pragma bea:global-element-parameter parameter="$registraTransaccionLBTR" element="ns0:registraTransaccionLBTR" location="../../OperacionesACH/xsd/operacionesACHTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/RegistraTransaccionLBTR/xsd/registraTransaccionLBTR_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/operacionesACHTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registraTransaccionLBTR";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RegistraTransaccionLBTR/xq/registraTransaccionLBTRHNIn/";

declare function xf:registraTransaccionLBTRHNIn($registraTransaccionLBTR as element(ns0:registraTransaccionLBTR))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PN_CODIGO_BANCO>{ data($registraTransaccionLBTR/BANK_ID) }</ns1:PN_CODIGO_BANCO>
            <ns1:PV_NUMERO_REFERENCIA>{ data($registraTransaccionLBTR/REFERENCE_NUMBER) }</ns1:PV_NUMERO_REFERENCIA>
            {
            	let $additionDate := fn-bea:dateTime-from-string-with-format('yyyy-MM-dd-HH:mm',fn:string($registraTransaccionLBTR/ADDITION_DATE/text()))
            	return
            	<ns1:PD_FECHA_ADICION>{ $additionDate }</ns1:PD_FECHA_ADICION>
            	
            }
            <ns1:PN_CORRELATIVO_ARCHIVO>{ data($registraTransaccionLBTR/CORRELATIVE_FILE) }</ns1:PN_CORRELATIVO_ARCHIVO>
            <ns1:PN_SECUENCIA_REGISTRO>{ data($registraTransaccionLBTR/REGISTRATION_SEQUENCE) }</ns1:PN_SECUENCIA_REGISTRO>
            <ns1:PV_TIPO_PERSONA>{ data($registraTransaccionLBTR/PERSON_KIND) }</ns1:PV_TIPO_PERSONA>
            <ns1:PV_NOMBRE_ORDENANTE>{ data($registraTransaccionLBTR/ORDERING_NAME) }</ns1:PV_NOMBRE_ORDENANTE>
            <ns1:PV_NUMERO_CUENTA_ORDENANTE>{ data($registraTransaccionLBTR/ACCOUNT_ORDERING) }</ns1:PV_NUMERO_CUENTA_ORDENANTE>
            <ns1:PV_NUMERO_IDENTIFICACION_O>{ data($registraTransaccionLBTR/ID_PERSON) }</ns1:PV_NUMERO_IDENTIFICACION_O>
            <ns1:PN_TIPO_CUENTA_ORDENANTE>{ data($registraTransaccionLBTR/ACCOUNT_TYPE_ORDERING) }</ns1:PN_TIPO_CUENTA_ORDENANTE>
            <ns1:PV_DIRECCION_ORDENANTE>{ data($registraTransaccionLBTR/ORDERING_ADDRES) }</ns1:PV_DIRECCION_ORDENANTE>
			{
            	let $dateBirthOrdering := fn-bea:dateTime-from-string-with-format('yyyy-MM-dd-HH:mm',fn:string($registraTransaccionLBTR/DATE_BIRTH_ORDERING/text()))
            	return
            	<ns1:PD_FECHA_NACIMIENTO_ORDENANTE>{ $dateBirthOrdering }</ns1:PD_FECHA_NACIMIENTO_ORDENANTE>
            	
            }            
            <ns1:PV_NOMBRE_BENEFICIARIO>{ data($registraTransaccionLBTR/BENEFICIARY_NAME) }</ns1:PV_NOMBRE_BENEFICIARIO>
            <ns1:PV_NUMERO_CUENTA_BENEFICIARIO>{ data($registraTransaccionLBTR/BENEFICIARY_ACCOUNT) }</ns1:PV_NUMERO_CUENTA_BENEFICIARIO>
            <ns1:PV_NUMERO_IDENTIFICACION_B>{ data($registraTransaccionLBTR/BENEFICIARY_ID) }</ns1:PV_NUMERO_IDENTIFICACION_B>
            <ns1:PV_DIRECCION_BENEFICIARIO>{ data($registraTransaccionLBTR/BENEFICIARY_ADDRES) }</ns1:PV_DIRECCION_BENEFICIARIO>
            <ns1:PV_TIPO_CUENTA_BENEFICIARIO>{ data($registraTransaccionLBTR/TYPE_ACCOUNT_BENEFICIARY) }</ns1:PV_TIPO_CUENTA_BENEFICIARIO>
            <ns1:PV_CODIGO_MONEDA>{ data($registraTransaccionLBTR/CURRENCY_CODE) }</ns1:PV_CODIGO_MONEDA>
            <ns1:PN_VALOR_TRANSACCION>{ data($registraTransaccionLBTR/TRANSACTION_VALUE) }</ns1:PN_VALOR_TRANSACCION>
            <ns1:PV_ESTADO>{ data($registraTransaccionLBTR/STATE) }</ns1:PV_ESTADO>
            <ns1:PV_NOMBRE_ARCHIVO_LBTR>{ data($registraTransaccionLBTR/NAME) }</ns1:PV_NOMBRE_ARCHIVO_LBTR>
			{
            	let $date := fn-bea:dateTime-from-string-with-format('yyyy-MM-dd-HH:mm',fn:string($registraTransaccionLBTR/DATE/text()))
            	return
            	<ns1:PD_FECHA_HORA>{ $date }</ns1:PD_FECHA_HORA>
            	
            }             
            <ns1:PN_CODIGO_CLIENTE>{ data($registraTransaccionLBTR/CLIENT_CODE) }</ns1:PN_CODIGO_CLIENTE>
			{
            	let $returnDate := fn-bea:dateTime-from-string-with-format('yyyy-MM-dd-HH:mm',fn:string($registraTransaccionLBTR/RETURN_DATE/text()))
            	return
            	<ns1:PD_FECHA_DEVOLUCION>{ $returnDate }</ns1:PD_FECHA_DEVOLUCION>
            	
            }              
            <ns1:PV_DETALLE_TRANSACCION>{ data($registraTransaccionLBTR/TRANSACTION_DETAILS) }</ns1:PV_DETALLE_TRANSACCION>
            <ns1:PN_ORIGEN_CATEGORIA>{ data($registraTransaccionLBTR/ORIGIN_CATEGORY) }</ns1:PN_ORIGEN_CATEGORIA>
        </ns1:InputParameters>
};

declare variable $registraTransaccionLBTR as element(ns0:registraTransaccionLBTR) external;

xf:registraTransaccionLBTRHNIn($registraTransaccionLBTR)
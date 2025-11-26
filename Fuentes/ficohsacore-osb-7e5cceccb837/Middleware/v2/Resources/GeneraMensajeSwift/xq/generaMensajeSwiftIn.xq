(:: pragma bea:global-element-parameter parameter="$generaMensajeSwiftRequest" element="ns1:generaMensajeSwiftRequest" location="../xsd/generaMensajeSwiftTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/PWS/generaMensajeSwift/xsd/generaMensajeSwift_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/generaMensajeSwiftTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/generaMensajeSwift";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/GeneraMensajeSwift/xq/generaMensajeSwiftIn/";

declare function xf:generaMensajeSwiftIn($generaMensajeSwiftRequest as element(ns1:generaMensajeSwiftRequest))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_TIPO_TRANSFERENCIA>{ data($generaMensajeSwiftRequest/TRANSFER_TYPE) }</ns0:PV_TIPO_TRANSFERENCIA>
            <ns0:PV_TIPO_MENSAJE>{ data($generaMensajeSwiftRequest/MESSAGE_TYPE) }</ns0:PV_TIPO_MENSAJE>
            <ns0:PV_NUMERO_REFERENCIA_TXN>{ data($generaMensajeSwiftRequest/TRANSACTION_ID) }</ns0:PV_NUMERO_REFERENCIA_TXN>
            {
            	let $transactionAmount := xs:decimal($generaMensajeSwiftRequest/TRANSACTION_AMOUT/text())
            	return
            		<ns0:PN_MONTO>{ fn-bea:format-number(fn-bea:decimal-round($transactionAmount, 2),"########0.00") }</ns0:PN_MONTO>
            }            
            <ns0:PV_CODIGO_MONEDA>{ data($generaMensajeSwiftRequest/TRANSACTION_CURRENCY) }</ns0:PV_CODIGO_MONEDA>
            <ns0:PV_FECHA_TRANSACCION>{ data($generaMensajeSwiftRequest/TRANSACTION_DATE) }</ns0:PV_FECHA_TRANSACCION>
            <ns0:PV_BIC_BANCO_ORIGEN>{ data($generaMensajeSwiftRequest/ORDERING_BANK_CODE) }</ns0:PV_BIC_BANCO_ORIGEN>
            <ns0:PN_CODIGO_CLIENTE_ORD>{ data($generaMensajeSwiftRequest/CUSTOMER_ID) }</ns0:PN_CODIGO_CLIENTE_ORD>
            <ns0:PV_NUMERO_IDENTIFICACION_ORD>{ data($generaMensajeSwiftRequest/CUSTOMER_LEGAL_ID) }</ns0:PV_NUMERO_IDENTIFICACION_ORD>
            <ns0:PV_NOMBRE_ORD>{ data($generaMensajeSwiftRequest/CUSTOMER_NAME) }</ns0:PV_NOMBRE_ORD>
            <ns0:PV_TIPO_CLIENTE_ORD>{ data($generaMensajeSwiftRequest/CUSTOMER_TYPE) }</ns0:PV_TIPO_CLIENTE_ORD>
            {
                for $CUSTOMER_DATE_OF_BIRTH in $generaMensajeSwiftRequest/CUSTOMER_DATE_OF_BIRTH
                return
                    <ns0:PV_FECHA_NACIMIENTO_ORD>{ data($CUSTOMER_DATE_OF_BIRTH) }</ns0:PV_FECHA_NACIMIENTO_ORD>
            }
            {
                for $CUSTOMER_ADDRESS in $generaMensajeSwiftRequest/CUSTOMER_ADDRESS
                return
                    <ns0:PV_DIRECCION_ORD>{ data($CUSTOMER_ADDRESS) }</ns0:PV_DIRECCION_ORD>
            }
            {
                for $CUSTOMER_COUNTRY_CODE in $generaMensajeSwiftRequest/CUSTOMER_COUNTRY_CODE
                return
                    <ns0:PV_PAIS_CLIENTE_ORD>{ data($CUSTOMER_COUNTRY_CODE) }</ns0:PV_PAIS_CLIENTE_ORD>
            }
            {
                for $CUSTOMER_COUNTRY_NAME in $generaMensajeSwiftRequest/CUSTOMER_COUNTRY_NAME
                return
                    <ns0:PV_PAIS_NOMBRE_CLIENTE_ORD>{ data($CUSTOMER_COUNTRY_NAME) }</ns0:PV_PAIS_NOMBRE_CLIENTE_ORD>
            }
            {
                for $CUSTOMER_COUNTRY_DESTINY in $generaMensajeSwiftRequest/CUSTOMER_COUNTRY_DESTINY
                return
                    <ns0:PV_PAIS_CLIENTE_DESTINO>{ data($CUSTOMER_COUNTRY_DESTINY) }</ns0:PV_PAIS_CLIENTE_DESTINO>
            }
            {
                for $CUSTOMER_CITY_NAME in $generaMensajeSwiftRequest/CUSTOMER_CITY_NAME
                return
                    <ns0:PV_CIUDAD>{ data($CUSTOMER_CITY_NAME) }</ns0:PV_CIUDAD>
            }
            {
                for $DEBIT_ACCOUNT in $generaMensajeSwiftRequest/DEBIT_ACCOUNT
                return
                    <ns0:PV_NUMERO_CUENTA_ORD>{ data($DEBIT_ACCOUNT) }</ns0:PV_NUMERO_CUENTA_ORD>
            }
            {
                for $ACCOUNT_TYPE in $generaMensajeSwiftRequest/ACCOUNT_TYPE
                return
                    <ns0:PV_TIPO_CUENTA_ORD>{ data($ACCOUNT_TYPE) }</ns0:PV_TIPO_CUENTA_ORD>
            }
            <ns0:PV_BIC_BANCO_DESTINO>{ data($generaMensajeSwiftRequest/BENEFICIARY_BANK_CODE) }</ns0:PV_BIC_BANCO_DESTINO>
            {
                for $BENEFICIARY_NAME in $generaMensajeSwiftRequest/BENEFICIARY_NAME
                return
                    <ns0:PV_NOMBRE_BENEFICIARIO>{ data($BENEFICIARY_NAME) }</ns0:PV_NOMBRE_BENEFICIARIO>
            }
            {
                for $BENEFICIARY_ACCOUNT in $generaMensajeSwiftRequest/BENEFICIARY_ACCOUNT
                return
                    <ns0:PV_NUMERO_CUENTA_BENEFICIARIO>{ data($BENEFICIARY_ACCOUNT) }</ns0:PV_NUMERO_CUENTA_BENEFICIARIO>
            }
            <ns0:PV_TIPO_CUENTA_BENEFICIARIO>{ data($generaMensajeSwiftRequest/BENEFICIARY_ACCOUNT_TYPE) }</ns0:PV_TIPO_CUENTA_BENEFICIARIO>
            {
                for $BENEFICIARY_ADDRESS in $generaMensajeSwiftRequest/BENEFICIARY_ADDRESS
                return
                    <ns0:PV_DIRECCION_BENEFICIARIO>{ data($BENEFICIARY_ADDRESS) }</ns0:PV_DIRECCION_BENEFICIARIO>
            }
            {
                for $BENEFICIARY_INFO in $generaMensajeSwiftRequest/BENEFICIARY_INFO
                return
                    <ns0:PV_DETALLE_TRANSACCION>{ data($BENEFICIARY_INFO) }</ns0:PV_DETALLE_TRANSACCION>
            }
            {
                for $OPERATION_TYPE in $generaMensajeSwiftRequest/OPERATION_TYPE
                return
                    <ns0:PV_TIPO_OPERACION>{ data($OPERATION_TYPE) }</ns0:PV_TIPO_OPERACION>
            }
            {
                for $TRANSACTION_CHARGES in $generaMensajeSwiftRequest/TRANSACTION_CHARGES
                return
                    <ns0:PV_TIPO_CARGO>{ data($TRANSACTION_CHARGES) }</ns0:PV_TIPO_CARGO>
            }
            {
                for $UNIQUE_REFERENCE in $generaMensajeSwiftRequest/UNIQUE_REFERENCE
                return
                    <ns0:PV_UETR>{ data($UNIQUE_REFERENCE) }</ns0:PV_UETR>
            }
            {
                for $BENEFICIARY_LEGAL_ID in $generaMensajeSwiftRequest/BENEFICIARY_LEGAL_ID
                return
                    <ns0:PV_REFERENCIA_SWIFT>{ data($BENEFICIARY_LEGAL_ID) }</ns0:PV_REFERENCIA_SWIFT>
            }
        </ns0:InputParameters>
};

declare variable $generaMensajeSwiftRequest as element(ns1:generaMensajeSwiftRequest) external;

xf:generaMensajeSwiftIn($generaMensajeSwiftRequest)

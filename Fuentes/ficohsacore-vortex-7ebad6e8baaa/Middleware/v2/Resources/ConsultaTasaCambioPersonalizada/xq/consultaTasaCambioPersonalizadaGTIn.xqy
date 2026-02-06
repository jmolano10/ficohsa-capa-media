xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaTasaCambioPersonalizada" element="ns0:consultaTasaCambioPersonalizada" location="../xsd/consultaTasaCambioPersonalizadaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABKGT/consultaTasaCambioPersonalizada/xsd/consultaTasaCambioPersonalizada_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaTasaCambioPersonalizadaTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaTasaCambioPersonalizada";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaTasaCambioPersonalizada/xq/consultaTasaCambioPersonalizadaGTIn/";

declare function xf:consultaTasaCambioPersonalizadaGTIn($consultaTasaCambioPersonalizada as element(ns0:consultaTasaCambioPersonalizada))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_CODIGOMONEDAORIGEN>{ data($consultaTasaCambioPersonalizada/ns0:RATE_INFORMATION/ns0:SOURCE_CURRENCY) }</ns1:PV_CODIGOMONEDAORIGEN>
            {
                for $TARGET_CURRENCY in $consultaTasaCambioPersonalizada/ns0:RATE_INFORMATION/ns0:TARGET_CURRENCY
                return
                    <ns1:PV_CODIGOMONEDADESTINO>{ data($TARGET_CURRENCY) }</ns1:PV_CODIGOMONEDADESTINO>
            }
            {
                for $AUTHORIZATION_TICKET in $consultaTasaCambioPersonalizada/ns0:RATE_INFORMATION/ns0:AUTHORIZATION_TICKET
                return
                    <ns1:PV_CODIGOAUTORIZACION>{ data($AUTHORIZATION_TICKET) }</ns1:PV_CODIGOAUTORIZACION>
            }
            <ns1:PV_TIPODETASA>{ data($consultaTasaCambioPersonalizada/ns0:RATE_INFORMATION/ns0:RATE_TYPE) }</ns1:PV_TIPODETASA>
            {
                for $AMOUNT in $consultaTasaCambioPersonalizada/ns0:TRANSACTION_INFORMATION/ns0:AMOUNT
                return
                    <ns1:PN_MONTO>{ data($AMOUNT) }</ns1:PN_MONTO>
            }
            <ns1:PV_CANAL>{ data($consultaTasaCambioPersonalizada/ns0:TRANSACTION_INFORMATION/ns0:CHANNEL) }</ns1:PV_CANAL>
            {
                for $TRANSACTION_TYPE in $consultaTasaCambioPersonalizada/ns0:TRANSACTION_INFORMATION/ns0:TRANSACTION_TYPE
                return
                    <ns1:PV_TIPODETRANSACCION>{ data($TRANSACTION_TYPE) }</ns1:PV_TIPODETRANSACCION>
            }
            {
                for $TARGET_CUSTOMER in $consultaTasaCambioPersonalizada/ns0:CUSTOMER/ns0:TARGET_CUSTOMER
                return
                    <ns1:PV_CODIGOCLIENTEDESTINO>{ data($TARGET_CUSTOMER) }</ns1:PV_CODIGOCLIENTEDESTINO>
            }
            {
                for $SOURCE_CUSTOMER in $consultaTasaCambioPersonalizada/ns0:CUSTOMER/ns0:SOURCE_CUSTOMER
                return
                    <ns1:PV_CODIGOCLIENTEORIGEN>{ data($SOURCE_CUSTOMER) }</ns1:PV_CODIGOCLIENTEORIGEN>
            }
            {
                for $CREDIT_ACCOUNT in $consultaTasaCambioPersonalizada/ns0:ACCOUNT/ns0:CREDIT_ACCOUNT
                return
                    <ns1:PV_CUENTAACREDITAR>{ data($CREDIT_ACCOUNT) }</ns1:PV_CUENTAACREDITAR>
            }
            {
                for $DEBIT_ACCOUNT in $consultaTasaCambioPersonalizada/ns0:ACCOUNT/ns0:DEBIT_ACCOUNT
                return
                    <ns1:PV_CUENTADEBITAR>{ data($DEBIT_ACCOUNT) }</ns1:PV_CUENTADEBITAR>
            }
        </ns1:InputParameters>
};

declare variable $consultaTasaCambioPersonalizada as element(ns0:consultaTasaCambioPersonalizada) external;

xf:consultaTasaCambioPersonalizadaGTIn($consultaTasaCambioPersonalizada)
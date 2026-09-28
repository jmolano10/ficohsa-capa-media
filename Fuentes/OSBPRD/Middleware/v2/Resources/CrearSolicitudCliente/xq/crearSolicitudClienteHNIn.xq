(:: pragma bea:global-element-parameter parameter="$crearSolicitudCliente" element="ns1:crearSolicitudCliente" location="../../DesembolsoLineaCredito/xsd/desembolsoLineaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/DesembolsoLineaCredito/crearSolicitudCliente/xsd/crearSolicitudCliente_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/crearSolicitudCliente";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/desembolsoLineaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CrearSolicitudCliente/xq/crearSolicitudClienteHNIn/";

declare function xf:crearSolicitudClienteHNIn($crearSolicitudCliente as element(ns1:crearSolicitudCliente), $channelUser as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:P_CUSTOMER_ID>{ data($crearSolicitudCliente/CUSTOMER_ID) }</ns0:P_CUSTOMER_ID>
            <ns0:P_CREDIT_LINE_ID>{ data($crearSolicitudCliente/CREDIT_LINE_ID) }</ns0:P_CREDIT_LINE_ID>
            <ns0:P_DESTINATION_PRODUCT_ID>{ data($crearSolicitudCliente/DESTINATION_PRODUCT/ID) }</ns0:P_DESTINATION_PRODUCT_ID>
            <ns0:P_DESTINATION_PRODUCT_TYPE>{ data($crearSolicitudCliente/DESTINATION_PRODUCT/TYPE) }</ns0:P_DESTINATION_PRODUCT_TYPE>
            <ns0:P_LOAN_CURRENCY>{ data($crearSolicitudCliente/LOAN_CURRENCY) }</ns0:P_LOAN_CURRENCY>
            <ns0:P_PAYMENT_TERMS>{ data($crearSolicitudCliente/PAYMENT_TERMS) }</ns0:P_PAYMENT_TERMS>
            <ns0:P_REQUEST_AMOUNT>{ data($crearSolicitudCliente/REQUEST_AMOUNT) }</ns0:P_REQUEST_AMOUNT>
            <ns0:P_REPAYMENT_TYPE_CODE>{ data($crearSolicitudCliente/REPAYMENT_TYPE/CODE) }</ns0:P_REPAYMENT_TYPE_CODE>
            <ns0:P_FRECUENCY>{ data($crearSolicitudCliente/REPAYMENT_TYPE/FRECUENCY) }</ns0:P_FRECUENCY>
            <ns0:P_INITIAL_PAYMENT_DATE>{ data($crearSolicitudCliente/REPAYMENT_TYPE/INITIAL_PAYMENT_DATE) }</ns0:P_INITIAL_PAYMENT_DATE>
            <ns0:P_PAYMENT_DAY>{ data($crearSolicitudCliente/REPAYMENT_TYPE/PAYMENT_DAY) }</ns0:P_PAYMENT_DAY>
            <ns0:P_DEBIT_ACCOUNT_ID>{ data($crearSolicitudCliente/DEBIT_ACCOUNT_ID) }</ns0:P_DEBIT_ACCOUNT_ID>
            <ns0:P_REQUEST_USER>{ data($crearSolicitudCliente/REQUEST_USER) }</ns0:P_REQUEST_USER>
            <ns0:P_CHANNEL_USER>{ $channelUser }</ns0:P_CHANNEL_USER>
        </ns0:InputParameters>
};

declare variable $crearSolicitudCliente as element(ns1:crearSolicitudCliente) external;
declare variable $channelUser as xs:string external;

xf:crearSolicitudClienteHNIn($crearSolicitudCliente, $channelUser)
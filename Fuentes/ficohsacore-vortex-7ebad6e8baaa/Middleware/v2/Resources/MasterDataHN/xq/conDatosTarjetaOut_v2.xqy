xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$DatosTarjetas_RSP" element="ns1:OutputParameters" location="../../../BusinessServices/MasterDataHN/conDatoTarjetas_v2/xsd/conDatoTarjetas_v2_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaDatosTarjetaCreditoResponse" location="../../ConsultaDatosTarjetaCredito/xsd/consultaDatosTarjetaCreditoTypes.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatoTarjetas_v2";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDatosTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/MasterDataHN/xq/conDatosTarjetaOut_v2/";

declare function xf:conDatosTarjetaOut_v2($DatosTarjetas_RSP as element(ns1:OutputParameters),
    $tipoTarjeta as xs:string)
    as element(ns0:consultaDatosTarjetaCreditoResponse) {
        <ns0:consultaDatosTarjetaCreditoResponse>
             <ns0:consultaDatosTarjetaCreditoResponseType>      
                <ns0:consultaDatosTarjetaCreditoResponseRecordType>
            <CARD_NUMBER>{ data($DatosTarjetas_RSP/ns1:RowSet[1]/ns1:Row[1]/ns1:Column[@name="numtarjeta"]) }</CARD_NUMBER>
            <ACCOUNT_HOLDER_NAME>{ data($DatosTarjetas_RSP/ns1:RowSet[1]/ns1:Row[1]/ns1:Column[@name="account_name"]) }</ACCOUNT_HOLDER_NAME>
            <CARD_HOLDER_NAME>{ data($DatosTarjetas_RSP/ns1:RowSet[1]/ns1:Row[1]/ns1:Column[@name="cardholder_name"]) }</CARD_HOLDER_NAME>
            <CARD_TYPE>{ data($tipoTarjeta) }</CARD_TYPE>
            <CUSTOMER_ID>{ data($DatosTarjetas_RSP/ns1:RowSet[1]/ns1:Row[1]/ns1:Column[@name="customer_id"]) }</CUSTOMER_ID>
            <CARD_HOLDER_LEGAL_ID>{ data($DatosTarjetas_RSP/ns1:RowSet[1]/ns1:Row[1]/ns1:Column[@name="card_holder_id"]) }</CARD_HOLDER_LEGAL_ID>
            <ACCOUNT_HOLDER_LEGAL_ID>{ data($DatosTarjetas_RSP/ns1:RowSet[1]/ns1:Row[1]/ns1:Column[@name="account_holder_legal_id"]) }</ACCOUNT_HOLDER_LEGAL_ID>
            <ACCOUNT_NUMBER>{ data($DatosTarjetas_RSP/ns1:RowSet[1]/ns1:Row[1]/ns1:Column[@name="numcuenta"]) }</ACCOUNT_NUMBER>
            <PRODUCT>TRC</PRODUCT>
            <AFINITY_GROUP>{ data($DatosTarjetas_RSP/ns1:RowSet[1]/ns1:Row[1]/ns1:Column[@name="logo"]) }</AFINITY_GROUP>
            <ACCOUNT_STATUS>{ data($DatosTarjetas_RSP/ns1:RowSet[1]/ns1:Row[1]/ns1:Column[@name="EstadoCuenta"]) }</ACCOUNT_STATUS>
            <CARD_STATUS>{ data($DatosTarjetas_RSP/ns1:RowSet[1]/ns1:Row[1]/ns1:Column[@name="EstadoPlastico"]) }</CARD_STATUS>
            <CARD_EXPIRATION_DATE>{ data($DatosTarjetas_RSP/ns1:RowSet[1]/ns1:Row[1]/ns1:Column[@name="fecexpira"]) }</CARD_EXPIRATION_DATE>
                </ns0:consultaDatosTarjetaCreditoResponseRecordType>
            </ns0:consultaDatosTarjetaCreditoResponseType>
        </ns0:consultaDatosTarjetaCreditoResponse>
};

declare variable $DatosTarjetas_RSP as element(ns1:OutputParameters) external;
declare variable $tipoTarjeta as xs:string external;

xf:conDatosTarjetaOut_v2($DatosTarjetas_RSP,
    $tipoTarjeta)
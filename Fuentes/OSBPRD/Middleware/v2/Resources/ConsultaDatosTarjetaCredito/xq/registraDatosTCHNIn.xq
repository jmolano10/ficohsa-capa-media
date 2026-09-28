(:: pragma bea:global-element-parameter parameter="$DatosTarjetas_RSP" element="ns1:OutputParameters" location="../../../BusinessServices/MasterDataHN/conDatoTarjetas_v2/xsd/conDatoTarjetas_v2_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/CLIENTDATA/registraDatosTC_v2/xsd/registraDatosTC_v2_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatoTarjetas_v2";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registraDatosTC_v2";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDatosTarjetaCredito/xq/registraDatosTCHNIn/";

declare function xf:registraDatosTCHNIn($DatosTarjetas_RSP as element(ns1:OutputParameters),
    $tipoTarjeta as xs:string,
    $countryCode as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PT_DATOS_TARJETA>
                <ns0:PT_DATOS_TARJETA_ITEM>
                    <ns0:CARD_NUMBER>{ data($DatosTarjetas_RSP/ns1:RowSet[1]/ns1:Row[1]/ns1:Column[@name="numtarjeta"]) }</ns0:CARD_NUMBER>
                    <ns0:ACCOUNT_HOLDER_NAME>{ data($DatosTarjetas_RSP/ns1:RowSet[1]/ns1:Row[1]/ns1:Column[@name="account_name"]) }</ns0:ACCOUNT_HOLDER_NAME>
                    <ns0:CARD_HOLDER_NAME>{ data($DatosTarjetas_RSP/ns1:RowSet[1]/ns1:Row[1]/ns1:Column[@name="cardholder_name"]) }</ns0:CARD_HOLDER_NAME>
                    <ns0:CARD_TYPE>{ data($tipoTarjeta) }</ns0:CARD_TYPE>
                    <ns0:CUSTOMER_ID>{ data($DatosTarjetas_RSP/ns1:RowSet[1]/ns1:Row[1]/ns1:Column[@name="customer_id"]) }</ns0:CUSTOMER_ID>
                    <ns0:CARD_HOLDER_LEGAL_ID>{ data($DatosTarjetas_RSP/ns1:RowSet[1]/ns1:Row[1]/ns1:Column[@name="card_holder_id"]) }</ns0:CARD_HOLDER_LEGAL_ID>
                    <ns0:ACCOUNT_HOLDER_LEGAL_ID>{ data($DatosTarjetas_RSP/ns1:RowSet[1]/ns1:Row[1]/ns1:Column[@name="account_holder_legal_id"]) }</ns0:ACCOUNT_HOLDER_LEGAL_ID>
                    <ns0:ACCOUNT_NUMBER>{ data($DatosTarjetas_RSP/ns1:RowSet[1]/ns1:Row[1]/ns1:Column[@name="numcuenta"]) }</ns0:ACCOUNT_NUMBER>
                    <ns0:PRODUCT>TRC</ns0:PRODUCT>
                    <ns0:AFINITY_GROUP>{ data($DatosTarjetas_RSP/ns1:RowSet[1]/ns1:Row[1]/ns1:Column[@name="logo"]) }</ns0:AFINITY_GROUP>
                    <ns0:ACCOUNT_STATUS>{ data($DatosTarjetas_RSP/ns1:RowSet[1]/ns1:Row[1]/ns1:Column[@name="EstadoCuenta"]) }</ns0:ACCOUNT_STATUS>
                    <ns0:CARD_STATUS>{ data($DatosTarjetas_RSP/ns1:RowSet[1]/ns1:Row[1]/ns1:Column[@name="EstadoPlastico"]) }</ns0:CARD_STATUS>
                    <ns0:CARD_EXPIRATION_DATE>{ data($DatosTarjetas_RSP/ns1:RowSet[1]/ns1:Row[1]/ns1:Column[@name="fecexpira"]) }</ns0:CARD_EXPIRATION_DATE>
                </ns0:PT_DATOS_TARJETA_ITEM>
            </ns0:PT_DATOS_TARJETA>
            <ns0:PV_COUNTRY_CODE>{ $countryCode }</ns0:PV_COUNTRY_CODE>
        </ns0:InputParameters>
};

declare variable $DatosTarjetas_RSP as element(ns1:OutputParameters) external;
declare variable $tipoTarjeta as xs:string external;
declare variable $countryCode as xs:string external;

xf:registraDatosTCHNIn($DatosTarjetas_RSP,
    $tipoTarjeta,
    $countryCode)
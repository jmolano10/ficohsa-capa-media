xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$pagoRecaudo" element="ns1:pagoRecaudo" location="../../../../Business_Resources/pagoRecaudos/PagoRecaudo/pagoRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABKPA/registraPagoRecaudoTC/xsd/registraPagoRecaudoTC_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registraPagoRecaudoTC";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRecaudoPA/xq/registraPagoRecaudoTCIn/";

declare function xf:registraPagoRecaudoTCIn($pagoRecaudo as element(ns1:pagoRecaudo),
    $secuenciaPago as xs:string,
    $descripcion as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_IDCONVENIO>{ data($pagoRecaudo/CONTRACT_ID) }</ns0:PV_IDCONVENIO>
            <ns0:PV_CODIGODEUDOR>{ data($pagoRecaudo/DEBTOR_CODE) }</ns0:PV_CODIGODEUDOR>
            {
                let $result :=
                    for $DATA in $pagoRecaudo/ADDITIONAL_INFO/DATA[1]
                    return
                        <ns0:PV_CLAVE_DATA_1>{ data($DATA) }</ns0:PV_CLAVE_DATA_1>
                return
                    $result[1]
            }
            {
                let $result :=
                    for $DATA in $pagoRecaudo/ADDITIONAL_INFO/DATA[2]
                    return
                        <ns0:PV_CLAVE_DATA_2>{ data($DATA) }</ns0:PV_CLAVE_DATA_2>
                return
                    $result[1]
            }
            {
                let $result :=
                    for $DATA in $pagoRecaudo/ADDITIONAL_INFO/DATA[3]
                    return
                        <ns0:PV_CLAVE_DATA_3>{ data($DATA) }</ns0:PV_CLAVE_DATA_3>
                return
                    $result[1]
            }
            {
                let $result :=
                    for $DATA in $pagoRecaudo/ADDITIONAL_INFO/DATA[4]
                    return
                        <ns0:PV_CLAVE_DATA_4>{ data($DATA) }</ns0:PV_CLAVE_DATA_4>
                return
                    $result[1]
            }
            {
                let $result :=
                    for $DATA in $pagoRecaudo/ADDITIONAL_INFO/DATA[5]
                    return
                        <ns0:PV_CLAVE_DATA_5>{ data($DATA) }</ns0:PV_CLAVE_DATA_5>
                return
                    $result[1]
            }
            <ns0:PN_MONTO>{ data($pagoRecaudo/PAYMENT_INFORMATION/PAYMENT_AMOUNT) }</ns0:PN_MONTO>
            <ns0:PV_MONEDA>{ data($pagoRecaudo/PAYMENT_INFORMATION/PAYMENT_CURRENCY) }</ns0:PV_MONEDA>
            <ns0:PV_SECUENCIAPAGO>{ $secuenciaPago }</ns0:PV_SECUENCIAPAGO>
            <ns0:PV_TARJETACREDITO>{ data($pagoRecaudo/PAYMENT_INFORMATION/CREDIT_CARD_NUMBER) }</ns0:PV_TARJETACREDITO>
            <ns0:PV_NOMBRE_DEUDOR>{ data($pagoRecaudo/DEBTOR_NAME) }</ns0:PV_NOMBRE_DEUDOR>
            <ns0:PV_DESCRIPCION>{ $descripcion }</ns0:PV_DESCRIPCION>
            <ns0:PD_FECHA>{ fn:adjust-dateTime-to-timezone(fn:current-dateTime(),()) }</ns0:PD_FECHA>
        </ns0:InputParameters>
};

declare variable $pagoRecaudo as element(ns1:pagoRecaudo) external;
declare variable $secuenciaPago as xs:string external;
declare variable $descripcion as xs:string external;

xf:registraPagoRecaudoTCIn($pagoRecaudo,
    $secuenciaPago,
    $descripcion)
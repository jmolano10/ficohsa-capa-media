xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$pagoRecaudo" element="ns1:pagoRecaudo" location="../../../../Business_Resources/pagoRecaudos/PagoRecaudo/pagoRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultadeparametroscoreResponse" element="ns0:ConsultadeparametroscoreResponse" location="../../../../Business_Resources/Core/Resources/XMLSchema_1632682327.xsd" ::)
(:: pragma bea:global-element-return element="ns2:InputParameters" location="../../../BusinessServices/ABK/pagoRecaudoAbanks/xsd/pagoRecaudoAbanks_sp.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRecaudo/xq/pagoRecaudoPagoAbanksIn/";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/pagoRecaudoAbanks";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";

declare function xf:pagoRecaudoPagoAbanksIn($pagoRecaudo as element(ns1:pagoRecaudo),
    $consultadeparametroscoreResponse as element(ns0:ConsultadeparametroscoreResponse),
    $string1 as xs:string)
    as element(ns2:InputParameters) {
        <ns2:InputParameters>
            <ns2:PV_CODIGO_CONTRATO>{ data($pagoRecaudo/CONTRACT_ID) }</ns2:PV_CODIGO_CONTRATO>
            <ns2:PV_CODIGO_DEUDOR>{ data($pagoRecaudo/DEBTOR_CODE) }</ns2:PV_CODIGO_DEUDOR>
            <ns2:PN_CANTIDAD_FACTURAS>0</ns2:PN_CANTIDAD_FACTURAS>
            <ns2:PV_NUMERO_FACTURA>{ data($pagoRecaudo/BILL_INFORMATION/BILL_NUMBER) }</ns2:PV_NUMERO_FACTURA>            
            <ns2:PV_MONEDA>{ data($pagoRecaudo/PAYMENT_INFORMATION/PAYMENT_CURRENCY) }</ns2:PV_MONEDA>
            {
                let $BUYRATE := $consultadeparametroscoreResponse/WSCOREPARAMETERSType[1]/gWSCOREPARAMETERSDetailType/mWSCOREPARAMETERSDetailType[1]/BUYRATE
                let $SELLRATE := $consultadeparametroscoreResponse/WSCOREPARAMETERSType[1]/gWSCOREPARAMETERSDetailType/mWSCOREPARAMETERSDetailType[1]/SELLRATE
                return
                    if (data($pagoRecaudo/PAYMENT_INFORMATION/PAYMENT_CURRENCY) = "HNL") then
                    (
                    	<ns2:PV_TASA_CAMBIO>{ data($SELLRATE) }</ns2:PV_TASA_CAMBIO>
                    ) else (
                    	<ns2:PV_TASA_CAMBIO>{ data($BUYRATE) }</ns2:PV_TASA_CAMBIO>
                    )
            }                                        
            <ns2:PN_MONTO>{ data($pagoRecaudo/PAYMENT_INFORMATION/PAYMENT_AMOUNT) }</ns2:PN_MONTO>
            {
                for $USER in $consultadeparametroscoreResponse/WSCOREPARAMETERSType[1]/gWSCOREPARAMETERSDetailType/mWSCOREPARAMETERSDetailType[1]/USER
                return
                    <ns2:PV_USUARIO>{ data($USER) }</ns2:PV_USUARIO>
            }
            {
                for $USERAGENCYCODE in $consultadeparametroscoreResponse/WSCOREPARAMETERSType[1]/gWSCOREPARAMETERSDetailType/mWSCOREPARAMETERSDetailType[1]/USERAGENCYCODE
                return
                    <ns2:PV_AGENCIA>{ data($USERAGENCYCODE) }</ns2:PV_AGENCIA>
            }
            {
                for $COREDATE in $consultadeparametroscoreResponse/WSCOREPARAMETERSType[1]/gWSCOREPARAMETERSDetailType/mWSCOREPARAMETERSDetailType[1]/COREDATE
                return
                    <ns2:PV_FECHA_VALIDA>{ data($COREDATE) }</ns2:PV_FECHA_VALIDA>
            }
            <ns2:PV_SECUENCIA_T24>{ $string1 }</ns2:PV_SECUENCIA_T24>
        </ns2:InputParameters>
};

declare variable $pagoRecaudo as element(ns1:pagoRecaudo) external;
declare variable $consultadeparametroscoreResponse as element(ns0:ConsultadeparametroscoreResponse) external;
declare variable $string1 as xs:string external;

xf:pagoRecaudoPagoAbanksIn($pagoRecaudo,
    $consultadeparametroscoreResponse,
    $string1)
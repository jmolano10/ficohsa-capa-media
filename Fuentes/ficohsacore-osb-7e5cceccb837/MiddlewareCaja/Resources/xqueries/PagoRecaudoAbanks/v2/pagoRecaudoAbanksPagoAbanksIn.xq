(:: pragma bea:global-element-parameter parameter="$pagoRecaudoAbanks1" element="ns2:pagoRecaudoAbanks" location="../../../xsds/PagoRecaudoAbanks/PagoRecaudoAbanks.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultadeparametroscoreResponse1" element="ns0:ConsultadeparametroscoreResponse" location="../../../xsds/Core/XMLSchema_1632682327.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../xsds/PagoRecaudoAbanks/pagoRecaudoAbanks/v2/pagoRecaudoAbanks_v2_sp.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoAbanksTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/pagoRecaudoAbanks_v2";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoRecaudoAbanks/v2/pagoRecaudoAbanksPagoAbanksIn/";

declare function xf:pagoRecaudoAbanksPagoAbanksIn($pagoRecaudoAbanks1 as element(ns2:pagoRecaudoAbanks),
    $consultadeparametroscoreResponse1 as element(ns0:ConsultadeparametroscoreResponse),
    $string1 as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_CODIGO_CONTRATO>{ data($pagoRecaudoAbanks1/CONTRACT_ID) }</ns1:PV_CODIGO_CONTRATO>
            <ns1:PV_CODIGO_DEUDOR>{ data($pagoRecaudoAbanks1/DEBTOR_CODE) }</ns1:PV_CODIGO_DEUDOR>
            <ns1:PN_CANTIDAD_FACTURAS>
            { 
            	let $numberOfBills := fn:string($pagoRecaudoAbanks1/NUMBER_OF_BILLS/text())
            	return
            	if ($numberOfBills != "") then (
            		$numberOfBills
            	) else (
            		"0"
            	) 
            }
            </ns1:PN_CANTIDAD_FACTURAS>
            <ns1:PV_NUMERO_FACTURA>{ data($pagoRecaudoAbanks1/BILL_NUMBER) }</ns1:PV_NUMERO_FACTURA>
            <ns1:PV_CODIGO_DEUDOR>{ data($pagoRecaudoAbanks1/DEBTOR_CODE) }</ns1:PV_CODIGO_DEUDOR>
            <ns1:PV_MONEDA>{ data($pagoRecaudoAbanks1/CURRENCY) }</ns1:PV_MONEDA>
            {
                let $BUYRATE := $consultadeparametroscoreResponse1/WSCOREPARAMETERSType[1]/gWSCOREPARAMETERSDetailType/mWSCOREPARAMETERSDetailType[1]/BUYRATE
                let $SELLRATE := $consultadeparametroscoreResponse1/WSCOREPARAMETERSType[1]/gWSCOREPARAMETERSDetailType/mWSCOREPARAMETERSDetailType[1]/SELLRATE
                return
                    if (data($pagoRecaudoAbanks1/CURRENCY) = "HNL") then
                    (
                    	<ns1:PV_TASA_CAMBIO>{ data($SELLRATE) }</ns1:PV_TASA_CAMBIO>
                    ) else (
                    	<ns1:PV_TASA_CAMBIO>{ data($BUYRATE) }</ns1:PV_TASA_CAMBIO>
                    )
            }    
            <ns1:PN_MONTO>{ data($pagoRecaudoAbanks1/AMOUNT) }</ns1:PN_MONTO>
            {
                for $USER in $consultadeparametroscoreResponse1/WSCOREPARAMETERSType[1]/gWSCOREPARAMETERSDetailType/mWSCOREPARAMETERSDetailType[1]/USER
                return
                    <ns1:PV_USUARIO>{ data($USER) }</ns1:PV_USUARIO>
            }
            {
                for $USERAGENCYCODE in $consultadeparametroscoreResponse1/WSCOREPARAMETERSType[1]/gWSCOREPARAMETERSDetailType/mWSCOREPARAMETERSDetailType[1]/USERAGENCYCODE
                return
                    <ns1:PV_AGENCIA>{ data($USERAGENCYCODE) }</ns1:PV_AGENCIA>
            }
            {
                for $COREDATE in $consultadeparametroscoreResponse1/WSCOREPARAMETERSType[1]/gWSCOREPARAMETERSDetailType/mWSCOREPARAMETERSDetailType[1]/COREDATE
                return
                    <ns1:PV_FECHA_VALIDA>{ data($COREDATE) }</ns1:PV_FECHA_VALIDA>
            }
            <ns1:PV_SECUENCIA_T24>{ $string1 }</ns1:PV_SECUENCIA_T24>
        </ns1:InputParameters>
};

declare variable $pagoRecaudoAbanks1 as element(ns2:pagoRecaudoAbanks) external;
declare variable $consultadeparametroscoreResponse1 as element(ns0:ConsultadeparametroscoreResponse) external;
declare variable $string1 as xs:string external;

xf:pagoRecaudoAbanksPagoAbanksIn($pagoRecaudoAbanks1,
    $consultadeparametroscoreResponse1,
    $string1)
(:: pragma bea:global-element-parameter parameter="$consultaRecaudoAbanks1" element="ns2:consultaRecaudoAbanks" location="../../../xsds/ConsultaRecaudoAbanks/ConsultaRecaudoAbanks.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultadeparametroscoreResponse1" element="ns1:ConsultadeparametroscoreResponse" location="../../../xsds/Core/XMLSchema_1632682327.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../xsds/ConsultaRecaudoAbanks/consultaRecaudoAbanks/v2/consultaRecaudoAbanks_v2_sp.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoAbanksTypes";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaRecaudoAbanks_v2";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaRecaudoAbanks/v2/ConsultaRecaudoAbanksIn_v2/";

declare function xf:ConsultaRecaudoAbanksIn_v2($consultaRecaudoAbanks1 as element(ns2:consultaRecaudoAbanks),
    $consultadeparametroscoreResponse1 as element(ns1:ConsultadeparametroscoreResponse))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_CODIGO_CONTRATO>{ data($consultaRecaudoAbanks1/CONTRACT_ID) }</ns0:PV_CODIGO_CONTRATO>
            <ns0:PV_CODIGO_DEUDOR>{ data($consultaRecaudoAbanks1/DEBTOR_CODE) }</ns0:PV_CODIGO_DEUDOR>
            <ns0:PN_CANTIDAD_FACTURAS>
            { 
            	let $numberOfBills := fn:string($consultaRecaudoAbanks1/NUMBER_OF_BILLS/text())
            	return
            	if ($numberOfBills != "") then (
            		$numberOfBills
            	) else (
            		"0"
            	)
            }
            </ns0:PN_CANTIDAD_FACTURAS>
            {
                for $BILL_NUMBER in $consultaRecaudoAbanks1/BILL_NUMBER
                return
                    <ns0:PV_NUMERO_FACTURA>{ data($BILL_NUMBER) }</ns0:PV_NUMERO_FACTURA>
            }
            <ns0:PV_MONEDA>{ data($consultaRecaudoAbanks1/CURRENCY) }</ns0:PV_MONEDA>
            {
                let $BUYRATE := $consultadeparametroscoreResponse1/WSCOREPARAMETERSType[1]/gWSCOREPARAMETERSDetailType/mWSCOREPARAMETERSDetailType[1]/BUYRATE
                let $SELLRATE := $consultadeparametroscoreResponse1/WSCOREPARAMETERSType[1]/gWSCOREPARAMETERSDetailType/mWSCOREPARAMETERSDetailType[1]/SELLRATE
                return
                    if (data($consultaRecaudoAbanks1/CURRENCY) = "HNL") then
                    (
                    	<ns0:PV_TASA_CAMBIO>{ data($SELLRATE) }</ns0:PV_TASA_CAMBIO>
                    ) else (
                    	<ns0:PV_TASA_CAMBIO>{ data($BUYRATE) }</ns0:PV_TASA_CAMBIO>
                    )
            } 
            {
                for $USER in $consultadeparametroscoreResponse1/WSCOREPARAMETERSType[1]/gWSCOREPARAMETERSDetailType/mWSCOREPARAMETERSDetailType[1]/USER
                return
                    <ns0:PV_USUARIO>{ data($USER) }</ns0:PV_USUARIO>
            }
            {
                for $USERAGENCYCODE in $consultadeparametroscoreResponse1/WSCOREPARAMETERSType[1]/gWSCOREPARAMETERSDetailType/mWSCOREPARAMETERSDetailType[1]/USERAGENCYCODE
                return
                    <ns0:PV_AGENCIA>{ data($USERAGENCYCODE) }</ns0:PV_AGENCIA>
            }
            {
                for $COREDATE in $consultadeparametroscoreResponse1/WSCOREPARAMETERSType[1]/gWSCOREPARAMETERSDetailType/mWSCOREPARAMETERSDetailType[1]/COREDATE
                return
                    <ns0:PV_FECHA_VALIDA>{ data($COREDATE) }</ns0:PV_FECHA_VALIDA>
            }
        </ns0:InputParameters>
};

declare variable $consultaRecaudoAbanks1 as element(ns2:consultaRecaudoAbanks) external;
declare variable $consultadeparametroscoreResponse1 as element(ns1:ConsultadeparametroscoreResponse) external;

xf:ConsultaRecaudoAbanksIn_v2($consultaRecaudoAbanks1,
    $consultadeparametroscoreResponse1)
(:: pragma bea:global-element-parameter parameter="$consultadeparametroscoreResponse" element="ns0:ConsultadeparametroscoreResponse" location="../../../../Business_Resources/Core/Resources/XMLSchema_1632682327.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaRecaudo" element="ns2:consultaRecaudo" location="../../../../Business_Resources/recaudos/consultaRecaudo/consultaRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABK/consultaRecaudosAbanks/xsd/consultaRecaudoAbanks_sp.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaRecaudoAbanks";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRecaudo/xq/consultaRecaudoAbanksIn/";

declare function xf:consultaRecaudoAbanksIn($consultadeparametroscoreResponse as element(ns0:ConsultadeparametroscoreResponse),
    $consultaRecaudo as element(ns2:consultaRecaudo))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_CONTRATOT24>{ data($consultaRecaudo/CONTRACT_ID) }</ns1:PV_CONTRATOT24>
            <ns1:PV_MONEDA>{ data($consultaRecaudo/CURRENCY) }</ns1:PV_MONEDA>
            <ns1:PV_CODIGODEUDOR>{ data($consultaRecaudo/DEBTOR_CODE) }</ns1:PV_CODIGODEUDOR>
            <ns1:PV_NUMEROFACTURA>0</ns1:PV_NUMEROFACTURA>
            {
            	let $BUYRATE := $consultadeparametroscoreResponse/WSCOREPARAMETERSType[1]/gWSCOREPARAMETERSDetailType/mWSCOREPARAMETERSDetailType[1]/BUYRATE
                let $SELLRATE := $consultadeparametroscoreResponse/WSCOREPARAMETERSType[1]/gWSCOREPARAMETERSDetailType/mWSCOREPARAMETERSDetailType[1]/SELLRATE
                return
                	if (data($consultaRecaudo/CURRENCY) = "HNL") then (
                		<ns1:PV_TASACAMBIO>{ data($SELLRATE) }</ns1:PV_TASACAMBIO>
                	) else (
                		<ns1:PV_TASACAMBIO>{ data($BUYRATE) }</ns1:PV_TASACAMBIO>                	
                	)
            }
            {
                for $COREDATE in $consultadeparametroscoreResponse/WSCOREPARAMETERSType[1]/gWSCOREPARAMETERSDetailType/mWSCOREPARAMETERSDetailType[1]/COREDATE
                return
                    <ns1:PV_FECHAVALIDA>{ data($COREDATE) }</ns1:PV_FECHAVALIDA>
            }
            {
                for $USER in $consultadeparametroscoreResponse/WSCOREPARAMETERSType[1]/gWSCOREPARAMETERSDetailType/mWSCOREPARAMETERSDetailType[1]/USER
                return
                    <ns1:PV_USUARIO>{ data($USER) }</ns1:PV_USUARIO>
            }
            {
                for $USERAGENCYCODE in $consultadeparametroscoreResponse/WSCOREPARAMETERSType[1]/gWSCOREPARAMETERSDetailType/mWSCOREPARAMETERSDetailType[1]/USERAGENCYCODE
                return
                    <ns1:PV_AGENCIA>{ data($USERAGENCYCODE) }</ns1:PV_AGENCIA>
            }
        </ns1:InputParameters>
};

declare variable $consultadeparametroscoreResponse as element(ns0:ConsultadeparametroscoreResponse) external;
declare variable $consultaRecaudo as element(ns2:consultaRecaudo) external;

xf:consultaRecaudoAbanksIn($consultadeparametroscoreResponse,
    $consultaRecaudo)
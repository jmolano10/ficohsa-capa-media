(:: pragma bea:global-element-parameter parameter="$transferenciaInternacionalH2HRequest" element="ns1:transferenciaInternacionalH2HRequest" location="../../../TransferenciaInternacionalH2HICB/xsd/transferenciaInternacionalH2HICBTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../../../../Middleware/v2/BusinessServices/MDW/ConsultaCruceMoneda/xsd/Consulta_CruceMoneda_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/Consulta_CruceMoneda";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/transferenciaInternacionalH2HICBType";
declare namespace xf = "http://tempuri.org/MWHostToHost/v1/Resources/TransferenciaInternacionalH2H/xq/Consultacrucemoneda/consultamwcrucemonedaIN/";

declare function xf:consultamwcrucemonedaIN($transferenciaInternacionalH2HRequest as element(ns1:transferenciaInternacionalH2HRequest),
    $codigopais as xs:string,
    $monto as xs:string,
    $tasa as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_PAIS>{ $codigopais }</ns0:PV_PAIS>
            <ns0:PV_MONEDAORIGEN>{ data($transferenciaInternacionalH2HRequest/TRANSFERS_INT/TRANSFER_INT[1]/DEBIT_CURRENCY) }</ns0:PV_MONEDAORIGEN>
            {
                for $DESTINATION_CURRENCY in $transferenciaInternacionalH2HRequest/TRANSFERS_INT/TRANSFER_INT[1]/DESTINATION_CURRENCY
                return
                    <ns0:PV_MONEDADESTINO>{ data($DESTINATION_CURRENCY) }</ns0:PV_MONEDADESTINO>
            }
        </ns0:InputParameters>
};

declare variable $transferenciaInternacionalH2HRequest as element(ns1:transferenciaInternacionalH2HRequest) external;
declare variable $codigopais as xs:string external;
declare variable $monto as xs:string external;
declare variable $tasa as xs:string external;

xf:consultamwcrucemonedaIN($transferenciaInternacionalH2HRequest,
    $codigopais,
    $monto,
    $tasa)

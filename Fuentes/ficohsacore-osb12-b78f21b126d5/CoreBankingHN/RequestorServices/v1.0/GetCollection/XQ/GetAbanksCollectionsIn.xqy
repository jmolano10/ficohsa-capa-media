xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/getCollectionTypes";
(:: import schema at "../../../../../MWBanking/Collection/RequestorServices/XSD/getCollectionTypes.xsd" ::)
declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetAbanksCollections";
(:: import schema at "../../../../ProviderServices/XSD/GetAbanksCollections/GetAbanksCollections_sp.xsd" ::)
declare namespace ns3="T24WebServicesImpl";
(:: import schema at "../../../../ProviderServices/XSD/GetCoreParameters/GetCoreParameters.xsd" ::)

declare variable $GetCoreParametersResponse as element() (:: schema-element(ns3:ConsultadeparametroscoreResponse) ::) external;
declare variable $GetCollectionRequest as element() (:: schema-element(ns2:getCollectionRequest) ::) external;

declare function local:func($GetCoreParametersResponse as element() (:: schema-element(ns3:ConsultadeparametroscoreResponse) ::), 
                            $GetCollectionRequest as element() (:: schema-element(ns2:getCollectionRequest) ::)) 
                            as element() (:: schema-element(ns1:InputParameters) ::) {
    <ns1:InputParameters>
        <ns1:PV_CONTRATOT24>{fn:data($GetCollectionRequest/ns2:ContractId)}</ns1:PV_CONTRATOT24>
        <ns1:PV_MONEDA>{fn:data($GetCollectionRequest/ns2:Currency)}</ns1:PV_MONEDA>
        <ns1:PV_CODIGODEUDOR>{fn:data($GetCollectionRequest/ns2:DebtorCode)}</ns1:PV_CODIGODEUDOR>
        <ns1:PV_NUMEROFACTURA>0</ns1:PV_NUMEROFACTURA>
        {
            let $BUYRATE := $GetCoreParametersResponse/WSCOREPARAMETERSType[1]/gWSCOREPARAMETERSDetailType/mWSCOREPARAMETERSDetailType[1]/BUYRATE
            let $SELLRATE := $GetCoreParametersResponse/WSCOREPARAMETERSType[1]/gWSCOREPARAMETERSDetailType/mWSCOREPARAMETERSDetailType[1]/SELLRATE
            return
                if (data($GetCollectionRequest/ns2:Currency) = "HNL") then (
                      <ns1:PV_TASACAMBIO>{ data($SELLRATE) }</ns1:PV_TASACAMBIO>
                ) else (
                      <ns1:PV_TASACAMBIO>{ data($BUYRATE) }</ns1:PV_TASACAMBIO>                	
                )
        }
        {
            for $COREDATE in $GetCoreParametersResponse/WSCOREPARAMETERSType[1]/gWSCOREPARAMETERSDetailType/mWSCOREPARAMETERSDetailType[1]/COREDATE
            return
              <ns1:PV_FECHAVALIDA>{fn:data($COREDATE)}</ns1:PV_FECHAVALIDA>
        }
        {
            for $USER in $GetCoreParametersResponse/WSCOREPARAMETERSType[1]/gWSCOREPARAMETERSDetailType/mWSCOREPARAMETERSDetailType[1]/USER
            return
              <ns1:PV_USUARIO>{fn:data($USER)}</ns1:PV_USUARIO>
        }
        {
            for $USERAGENCYCODE in $GetCoreParametersResponse/WSCOREPARAMETERSType[1]/gWSCOREPARAMETERSDetailType/mWSCOREPARAMETERSDetailType[1]/USERAGENCYCODE
            return
              <ns1:PV_AGENCIA>{fn:data($USERAGENCYCODE)}</ns1:PV_AGENCIA>
        }
    </ns1:InputParameters>
};

local:func($GetCoreParametersResponse, $GetCollectionRequest)
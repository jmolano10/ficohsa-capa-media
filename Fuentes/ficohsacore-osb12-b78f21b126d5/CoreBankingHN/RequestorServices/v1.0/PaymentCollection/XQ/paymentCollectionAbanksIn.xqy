xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="T24WebServicesImpl";
(:: import schema at "../../../../ProviderServices/XSD/CoreBS/XMLSchema_1628019553.xsd" ::)
declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/paymentCollectionTypes";
(:: import schema at "../../../../../MWBanking/Collection/RequestorServices/XSD/paymentCollectionTypes.xsd" ::)
declare namespace ns3="http://xmlns.oracle.com/pcbpel/adapter/db/sp/PaymentCollectionAbanks";
(:: import schema at "../../../../ProviderServices/XSD/PaymentCollectionAbanks/PaymentCollectionAbanks_sp.xsd" ::)

declare variable $paymentCollectionRequest as element() (:: schema-element(ns1:paymentCollectionRequest) ::) external;
declare variable $string1 as xs:string external;
declare variable $getCoreParametersResponse as element() (:: schema-element(ns2:ConsultadeparametroscoreResponse) ::) external;

declare function local:func($paymentCollectionRequest as element() (:: schema-element(ns1:paymentCollectionRequest) ::), 
                            $string1 as xs:string, 
                            $getCoreParametersResponse as element() (:: schema-element(ns2:ConsultadeparametroscoreResponse) ::)) 
                            as element() (:: schema-element(ns3:InputParameters) ::) {
    <ns3:InputParameters>
          <ns2:PV_CODIGO_CONTRATO>{ data($paymentCollectionRequest/ns1:ContractId) }</ns2:PV_CODIGO_CONTRATO>
            <ns2:PV_CODIGO_DEUDOR>{ data($paymentCollectionRequest/ns1:DebtorCode) }</ns2:PV_CODIGO_DEUDOR>
            <ns2:PN_CANTIDAD_FACTURAS>0</ns2:PN_CANTIDAD_FACTURAS>
            <ns2:PV_NUMERO_FACTURA>{ data($paymentCollectionRequest/ns1:BillInformation/ns1:BillNumber) }</ns2:PV_NUMERO_FACTURA>            
            <ns2:PV_MONEDA>{ data($paymentCollectionRequest/ns1:PaymentInformation/ns1:PaymentCurrency) }</ns2:PV_MONEDA>
            {
                let $BUYRATE := $getCoreParametersResponse/WSCOREPARAMETERSType[1]/gWSCOREPARAMETERSDetailType/mWSCOREPARAMETERSDetailType[1]/BUYRATE
                let $SELLRATE := $getCoreParametersResponse/WSCOREPARAMETERSType[1]/gWSCOREPARAMETERSDetailType/mWSCOREPARAMETERSDetailType[1]/SELLRATE
                return
                    if (data($paymentCollectionRequest/ns1:PaymentInformation/ns1:PaymentCurrency) = "HNL") then
                    (
                    	<ns2:PV_TASA_CAMBIO>{ data($SELLRATE) }</ns2:PV_TASA_CAMBIO>
                    ) else (
                    	<ns2:PV_TASA_CAMBIO>{ data($BUYRATE) }</ns2:PV_TASA_CAMBIO>
                    )
            }                                        
            <ns2:PN_MONTO>{ data($paymentCollectionRequest/ns1:PaymentInformation/ns1:PaymentAmount) }</ns2:PN_MONTO>
            {
                for $USER in $getCoreParametersResponse/WSCOREPARAMETERSType[1]/gWSCOREPARAMETERSDetailType/mWSCOREPARAMETERSDetailType[1]/USER
                return
                    <ns2:PV_USUARIO>{ data($USER) }</ns2:PV_USUARIO>
            }
            {
                for $USERAGENCYCODE in $getCoreParametersResponse/WSCOREPARAMETERSType[1]/gWSCOREPARAMETERSDetailType/mWSCOREPARAMETERSDetailType[1]/USERAGENCYCODE
                return
                    <ns2:PV_AGENCIA>{ data($USERAGENCYCODE) }</ns2:PV_AGENCIA>
            }
            {
                for $COREDATE in $getCoreParametersResponse/WSCOREPARAMETERSType[1]/gWSCOREPARAMETERSDetailType/mWSCOREPARAMETERSDetailType[1]/COREDATE
                return
                    <ns2:PV_FECHA_VALIDA>{ data($COREDATE) }</ns2:PV_FECHA_VALIDA>
            }
            <ns2:PV_SECUENCIA_T24>{ $string1 }</ns2:PV_SECUENCIA_T24>
    </ns3:InputParameters>
};

local:func($paymentCollectionRequest, $string1, $getCoreParametersResponse)
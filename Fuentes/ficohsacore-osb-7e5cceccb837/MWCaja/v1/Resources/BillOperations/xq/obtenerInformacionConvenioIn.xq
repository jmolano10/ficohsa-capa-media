(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/Middleware/ObtenerInformacionConvenio/xsd/obtenerInformacionConvenio_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/obtenerInformacionConvenio";
declare namespace xf = "http://tempuri.org/MWCaja/v1/Resources/BillOperations/xq/obtenerInformacionConvenioIn/";

declare function xf:obtenerInformacionConvenioIn($sourceBank as xs:string,
    $contractId as xs:string,
    $operation as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_BANCOORIGEN>{ data($sourceBank) }</ns0:PV_BANCOORIGEN>
            <ns0:PV_CONTRATO>{ data($contractId) }</ns0:PV_CONTRATO>
            <ns0:PV_CODIGOOPERACIONCONVENIO>
            {
                 if($operation  = 'billQuery')then(
                  1
                  )else(2)
            }
            </ns0:PV_CODIGOOPERACIONCONVENIO>
        </ns0:InputParameters>
};

declare variable $sourceBank as xs:string external;
declare variable $contractId as xs:string external;
declare variable $operation as xs:string external;

xf:obtenerInformacionConvenioIn($sourceBank,
    $contractId,
    $operation)
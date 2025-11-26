xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/UpdateStateRelationOperationCollection";
(:: import schema at "../../../../ProviderServices/XSD/UpdateStateRelationOperationCollection/UpdateStateRelationOperationCollection_sp.xsd" ::)

declare variable $codigoContrato as xs:string external;
declare variable $codigoDeudor as xs:string external;
declare variable $codigoFactura as xs:string external;
declare variable $estadoAnterior as xs:string external;
declare variable $estadoNuevo as xs:string external;

declare function local:func($codigoContrato as xs:string, 
                            $codigoDeudor as xs:string, 
                            $codigoFactura as xs:string, 
                            $estadoAnterior as xs:string, 
                            $estadoNuevo as xs:string) 
                            as element() (:: schema-element(ns1:InputParameters) ::) {
    <ns1:InputParameters>
    <ns1:CODIGO_CONTRATO>{ $codigoContrato }</ns1:CODIGO_CONTRATO>
            <ns1:CODIGO_DEUDOR>{ $codigoDeudor }</ns1:CODIGO_DEUDOR>
            <ns1:CODIGO_FACTURA>{ $codigoFactura }</ns1:CODIGO_FACTURA>
            <ns1:ESTADO_ANTERIOR>{ $estadoAnterior }</ns1:ESTADO_ANTERIOR>
            <ns1:ESTADO_NUEVO>{ $estadoNuevo }</ns1:ESTADO_NUEVO>
    </ns1:InputParameters>
};

local:func($codigoContrato, $codigoDeudor, $codigoFactura, $estadoAnterior, $estadoNuevo)
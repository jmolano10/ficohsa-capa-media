(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/PMSV/consultarProveedores/xsd/consultarProveedores_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultarProveedoresResponse" location="../../PagosMasivos/xsd/pagosMasivosTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarProveedoresPagosMasivos";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaProveedoresPagosMasivos/xq/consultaProveedoresPagosMasivosHNOut/";

declare function xf:consultaProveedoresPagosMasivosHNOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:consultarProveedoresResponse) {
        <ns0:consultarProveedoresResponse>
            <CUSTOMER_ID>{ $outputParameters/ns1:PV_CODIGOCLIENTE/@* , $outputParameters/ns1:PV_CODIGOCLIENTE/node() }</CUSTOMER_ID>
            <SUPPLIERS>
            {
            	let $codigo := $outputParameters/ns1:PT_CODIGOPROVEEDOR/ns1:ITEM
            	let $nombre := $outputParameters/ns1:PT_NOMBREPROVEEDOR/ns1:ITEM
            	let $numeroId := $outputParameters/ns1:PT_NUMEROIDENTIFICACION/ns1:ITEM
            	let $codBanco := $outputParameters/ns1:PT_CODIGOBANCO/ns1:ITEM
            	let $siglaBanco := $outputParameters/ns1:PT_SIGLABANCOPROV/ns1:ITEM
            	let $nroCuenta := $outputParameters/ns1:PT_NOCUENTA/ns1:ITEM
            	let $tipoCuentaACH := $outputParameters/ns1:PT_TIPOCUENTAACH/ns1:ITEM
            	let $status := $outputParameters/ns1:PT_SITUACION/ns1:ITEM
            	for $i in 1 to count($codigo)
            	return
                <SUPPLIER>
                    <ID>{ data($codigo[$i]) }</ID>
                    <NAME>{ data($nombre[$i]) }</NAME>
                    <LEGAL_ID>{ data($numeroId[$i]) }</LEGAL_ID>
                    <DESTINATION_BANK>{ data($codBanco[$i]) }</DESTINATION_BANK>
                    <DESTINATION_BANK_DESC>{ data($siglaBanco[$i]) }</DESTINATION_BANK_DESC>
                    <ACCOUNT_NUMBER>{ data($nroCuenta[$i]) }</ACCOUNT_NUMBER>
                    <ACCOUNT_TYPE>{ data($tipoCuentaACH[$i]) }</ACCOUNT_TYPE>
                    <STATUS>{ data($status[$i]) }</STATUS>
                </SUPPLIER>
            }
            </SUPPLIERS>
        </ns0:consultarProveedoresResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:consultaProveedoresPagosMasivosHNOut($outputParameters)
xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$editarEstadoRegistroLote" element="ns0:editarEstadoRegistroLote" location="../../PagosMasivos/xsd/pagosMasivosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:editarValidezRegistroLote" location="../../../BusinessServices/MTR/editorRegistroLote/wsdl/editorRegistroLoteEndpoint.wsdl" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
declare namespace ns1 = "http://servicio.editarregistrolotews.mtrpmsv.cidenet.com.co/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/EditarEstadoRegistroLote/xq/editarEstadoRegistroLoteNIIn/";

declare function xf:editarEstadoRegistroLoteNIIn($editarEstadoRegistroLote as element(ns0:editarEstadoRegistroLote),
    $sourceBank as xs:string)
    as element(ns1:editarValidezRegistroLote) {
        <ns1:editarValidezRegistroLote>
            <idBancoOrigen>{ $sourceBank }</idBancoOrigen>
            <idCliente>{ data($editarEstadoRegistroLote/CUSTOMER_ID) }</idCliente>
            <idLote>{ data($editarEstadoRegistroLote/BANK_BATCH_ID) }</idLote>
            {
            	for $uploadDate in $editarEstadoRegistroLote/UPLOAD_DATE
            	return
            	<fecha>{ xs:dateTime(xs:date(data($editarEstadoRegistroLote/UPLOAD_DATE))) }</fecha>
            }
            <idUsuario>{ data($editarEstadoRegistroLote/USER_ID) }</idUsuario>
            {
            	for $status in string($editarEstadoRegistroLote/STATUS/text())
            	return
            		if( upper-case($status) = 'VALID' )then(
            			<aplica>S</aplica>
            		)else if( upper-case($status) = 'INVALID' )then(
            			<aplica>N</aplica>
            		)else()
            }
            {
                let $TRANSACTIONS := $editarEstadoRegistroLote/TRANSACTIONS
                return
                    <transacciones>
                        {
                            for $TRANSACTION in $TRANSACTIONS/TRANSACTION
                            return
                                <transaccion>
                                    <id>{ data($TRANSACTION/ID) }</id>
                                </transaccion>
                        }
                    </transacciones>
            }
        </ns1:editarValidezRegistroLote>
};

declare variable $editarEstadoRegistroLote as element(ns0:editarEstadoRegistroLote) external;
declare variable $sourceBank as xs:string external;

xf:editarEstadoRegistroLoteNIIn($editarEstadoRegistroLote,
    $sourceBank)
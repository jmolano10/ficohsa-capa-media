<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$editarEstadoRegistroLote" element="ns1:editarEstadoRegistroLote" location="../../PagosMasivos/xsd/pagosMasivosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:editarValidezRegistroLote" location="../../../BusinessServices/MTR/editorRegistroLote/wsdl/editorRegistroLoteEndpoint.wsdl" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/EditarEstadoRegistroLote/xq/editarEstadoRegistroLotePAIn/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
declare namespace ns0 = "http://servicio.editarregistrolotews.mtrpmsv.cidenet.com.co/";

declare function xf:editarEstadoRegistroLotePAIn($editarEstadoRegistroLote as element(ns1:editarEstadoRegistroLote),
	$sourceBank as xs:string)
    as element(ns0:editarValidezRegistroLote) {
        <ns0:editarValidezRegistroLote>
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
        </ns0:editarValidezRegistroLote>
};

declare variable $editarEstadoRegistroLote as element(ns1:editarEstadoRegistroLote) external;
declare variable $sourceBank as xs:string external;

xf:editarEstadoRegistroLotePAIn($editarEstadoRegistroLote, 
	$sourceBank)]]></con:xquery>
    <con:dependency location="../../PagosMasivos/xsd/pagosMasivosTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/PagosMasivos/xsd/pagosMasivosTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/MTR/editorRegistroLote/wsdl/editorRegistroLoteEndpoint.wsdl">
        <con:wsdl ref="Middleware/v2/BusinessServices/MTR/editorRegistroLote/wsdl/editorRegistroLoteEndpoint"/>
    </con:dependency>
</con:xqueryEntry>
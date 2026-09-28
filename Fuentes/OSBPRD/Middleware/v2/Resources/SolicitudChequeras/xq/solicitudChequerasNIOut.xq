(:: pragma bea:global-element-parameter parameter="$opCompraChequeraRespuesta" element="ns3:opCompraChequeraRespuesta" location="../../../BusinessServices/CTS/cheques/xsd/services.xsd" ::)
(:: pragma bea:global-element-return element="ns1:solicitudChequerasResponse" location="../xsd/solicitudChequerasTypes.xsd" ::)

declare namespace ns0 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace ns2 = "http://dto2.commons.ecobis.cobiscorp";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/solicitudChequerasTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/SolicitudChequeras/xq/solicitudChequerasNIOut/";
declare namespace ns4 = "http://dto2.sdf.cts.cobis.cobiscorp.com";
declare namespace ns3 = "http://service.srvaplcobischeques.ecobis.cobiscorp";

declare function xf:solicitudChequerasNIOut($opCompraChequeraRespuesta as element(ns3:opCompraChequeraRespuesta))
    as element(ns1:solicitudChequerasResponse) {
        <ns1:solicitudChequerasResponse>
            <ns1:solicitudChequerasResponseType>
                <ns1:solicitudChequerasResponseRecordType>
                    <ACCOUNT_NUMBER>{ data($opCompraChequeraRespuesta/ns0:compraChequera/ns0:cuenta/ns0:codCuentaHabiente) }</ACCOUNT_NUMBER>
                    <DESTINATION_BRANCH>{ data($opCompraChequeraRespuesta/ns0:compraChequera/ns0:chequera/ns0:oficinaDestino/ns0:codOficina) }</DESTINATION_BRANCH>
                    <CHEQUEBOOK_TYPE>{ data($opCompraChequeraRespuesta/ns0:compraChequera/ns0:chequera/ns0:tipoChequera) }</CHEQUEBOOK_TYPE>
                    <NO_OF_BOOKS>{ data($opCompraChequeraRespuesta/ns0:compraChequera/ns0:cuenta/ns0:numeroChequeras) }</NO_OF_BOOKS>
                    <FIRST_CHEQUE_NUMBER>{ data($opCompraChequeraRespuesta/ns0:compraChequera/ns0:chequera/ns0:numeroChequeInicio) }</FIRST_CHEQUE_NUMBER>
                    <LAST_CHEQUE_NUMBER>{ data($opCompraChequeraRespuesta/ns0:compraChequera/ns0:chequera/ns0:numeroChequeFin) }</LAST_CHEQUE_NUMBER>
                    <AUTHORIZED_CLAIMER>{ data($opCompraChequeraRespuesta/ns0:compraChequera/ns0:chequera/ns0:autorizadoRetirar) }</AUTHORIZED_CLAIMER>
					{
						let $fechaTransac:= $opCompraChequeraRespuesta/ns0:compraChequera/ns0:transaccion/ns0:fechaTransac
						return
							<DATE_TIME>{fn-bea:dateTime-to-string-with-format("yyyyMMdd",$fechaTransac)}</DATE_TIME>
					}
                </ns1:solicitudChequerasResponseRecordType>
            </ns1:solicitudChequerasResponseType>
        </ns1:solicitudChequerasResponse>
};

declare variable $opCompraChequeraRespuesta as element(ns3:opCompraChequeraRespuesta) external;

xf:solicitudChequerasNIOut($opCompraChequeraRespuesta)
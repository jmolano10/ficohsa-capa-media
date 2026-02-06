xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$opSolicitudChequeGerenciaRespuesta" element="ns3:opSolicitudChequeGerenciaRespuesta" location="../../../BusinessServices/CTS/cheques/xsd/services.xsd" ::)
(:: pragma bea:global-element-return element="ns2:emisionChequesGerenciaResponse" location="../xsd/emisionChequesGerenciaTypes.xsd" ::)

declare namespace ns0 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/emisionChequesGerenciaTypes";
declare namespace ns1 = "http://dto2.commons.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/EmisionChequesGerencia/xq/emisionChequesGerenciaNIOut/";
declare namespace ns4 = "http://dto2.sdf.cts.cobis.cobiscorp.com";
declare namespace ns3 = "http://service.srvaplcobischeques.ecobis.cobiscorp";

declare function xf:emisionChequesGerenciaNIOut($opSolicitudChequeGerenciaRespuesta as element(ns3:opSolicitudChequeGerenciaRespuesta))
    as element(ns2:emisionChequesGerenciaResponse) {
        <ns2:emisionChequesGerenciaResponse>
            {
                for $codCuentaHabiente in $opSolicitudChequeGerenciaRespuesta/ns0:cuenta/ns0:codCuentaHabiente
                return
                    <DEBIT_ACCOUNT>{ data($codCuentaHabiente) }</DEBIT_ACCOUNT>
            }
            <CHEQUE_AMOUNT>{ data($opSolicitudChequeGerenciaRespuesta/ns0:chequeGerencia/ns0:monto) }</CHEQUE_AMOUNT>
            {
                for $beneficiario in $opSolicitudChequeGerenciaRespuesta/ns0:chequeGerencia/ns0:beneficiario
                return
                    <BENEFICIARY_NAME>{ fn:replace(data($beneficiario),"[Ññ]", "#") }</BENEFICIARY_NAME>
            }
            {
                for $numeroCheque in $opSolicitudChequeGerenciaRespuesta/ns0:chequeGerencia/ns0:numeroCheque
                return
                    <CHEQUE_NUMBER>{ data($numeroCheque) }</CHEQUE_NUMBER>
            }
        </ns2:emisionChequesGerenciaResponse>
};

declare variable $opSolicitudChequeGerenciaRespuesta as element(ns3:opSolicitudChequeGerenciaRespuesta) external;

xf:emisionChequesGerenciaNIOut($opSolicitudChequeGerenciaRespuesta)
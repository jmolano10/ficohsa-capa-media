xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$emisionChequesGerencia" element="ns1:emisionChequesGerencia" location="../xsd/emisionChequesGerenciaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:opSolicitudChequeGerenciaSolicitud" location="../../../BusinessServices/CTS/cheques/xsd/services.xsd" ::)

declare namespace ns0 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace ns2 = "http://service.srvaplcobischeques.ecobis.cobiscorp";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/emisionChequesGerenciaTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/EmisionChequesGerencia/xq/emisionChequesGerenciaNIIn/";

declare function xf:emisionChequesGerenciaNIIn($emisionChequesGerencia as element(ns1:emisionChequesGerencia))
    as element(ns2:opSolicitudChequeGerenciaSolicitud) {
        <ns2:opSolicitudChequeGerenciaSolicitud>
            <ns0:contextoTransaccional>
                <ns0:codCanalOriginador>1</ns0:codCanalOriginador>
            </ns0:contextoTransaccional>
            <ns0:cuenta>
                <ns0:codCuentaHabiente>{ data($emisionChequesGerencia/DEBIT_ACCOUNT) }</ns0:codCuentaHabiente>
            </ns0:cuenta>
            <ns0:chequeGerencia>
                <ns0:beneficiario>{ data($emisionChequesGerencia/BENEFICIARY_NAME) }</ns0:beneficiario>
                {
                    for $AUTHORIZER_CLAIMER in $emisionChequesGerencia/AUTHORIZER_CLAIMER
                    return
                        <ns0:autorizado>{ data($AUTHORIZER_CLAIMER) }</ns0:autorizado>
                }
                <ns0:monto>{ data($emisionChequesGerencia/AMOUNT) }</ns0:monto>
                <ns0:oficinaRetiro>
                    <ns0:codOficina>{ data($emisionChequesGerencia/WITHDRAWAL_BRANCH_ID) }</ns0:codOficina>
                </ns0:oficinaRetiro>
                <ns0:descripcion>{ data($emisionChequesGerencia/DESCRIPTION) }</ns0:descripcion>
                <ns0:moneda>
                    <ns0:valSimboloMoneda>{ data($emisionChequesGerencia/CHEQUE_CURRENCY) }</ns0:valSimboloMoneda>
                </ns0:moneda>
                {
                    for $AUTHORIZER_CLAIMER_ID in $emisionChequesGerencia/AUTHORIZER_CLAIMER_ID
                    return
                        <ns0:idAutorizado>{ data($AUTHORIZER_CLAIMER_ID) }</ns0:idAutorizado>
                }
                <ns0:numeroReferenciaInterfaz>{ data($emisionChequesGerencia/INTERFACE_REFERENCE_NO) }</ns0:numeroReferenciaInterfaz>
            </ns0:chequeGerencia>
        </ns2:opSolicitudChequeGerenciaSolicitud>
};

declare variable $emisionChequesGerencia as element(ns1:emisionChequesGerencia) external;

xf:emisionChequesGerenciaNIIn($emisionChequesGerencia)
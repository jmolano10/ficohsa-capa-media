(:: pragma bea:global-element-parameter parameter="$solicitudChequeras" element="ns1:solicitudChequeras" location="../xsd/solicitudChequerasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:opCompraChequeraSolicitud" location="../../../BusinessServices/CTS/cheques/xsd/services.xsd" ::)

declare namespace ns0 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace ns2 = "http://service.srvaplcobischeques.ecobis.cobiscorp";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/solicitudChequerasTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/SolicitudChequeras/xq/solicitudChequerasNIIn/";

declare function xf:solicitudChequerasNIIn($solicitudChequeras as element(ns1:solicitudChequeras))
    as element(ns2:opCompraChequeraSolicitud) {
        <ns2:opCompraChequeraSolicitud>
            <ns0:contextoTransaccional>
                <ns0:codCanalOriginador>1</ns0:codCanalOriginador>
            </ns0:contextoTransaccional>
            <ns0:cuenta>
                <ns0:codCuentaHabiente>{ data($solicitudChequeras/ACCOUNT_NUMBER) }</ns0:codCuentaHabiente>
                <ns0:numeroChequeras>{ data($solicitudChequeras/NO_OF_BOOKS) }</ns0:numeroChequeras>
            </ns0:cuenta>
            <ns0:chequera>
                <ns0:oficinaDestino>
                    <ns0:codOficina>{ data($solicitudChequeras/DESTINATION_BRANCH) }</ns0:codOficina>
                </ns0:oficinaDestino>
                <ns0:tipoChequera>{ data($solicitudChequeras/CHEQUEBOOK_TYPE) }</ns0:tipoChequera>
            </ns0:chequera>
        </ns2:opCompraChequeraSolicitud>
};

declare variable $solicitudChequeras as element(ns1:solicitudChequeras) external;

xf:solicitudChequerasNIIn($solicitudChequeras)
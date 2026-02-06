xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$transferenciaInternacionalRequest" element="ns2:transferenciaInternacionalRequest" location="../xsd/transferenciaInternacionalType.xsd" ::)
(:: pragma bea:global-element-return element="ns0:opTransferenciaInternacionalSolicitud" location="../../../BusinessServices/CTS/transferencia/xsd/services.xsd" ::)

declare namespace ns0 = "http://service.srvaplcobistransferencia.ecobis.cobiscorp";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/transferenciaInternacionalType";
declare namespace ns1 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciaInternacional/xq/transferenciaIntlNIIn/";

declare function xf:transferenciaIntlNIIn($transferenciaInternacionalRequest as element(ns2:transferenciaInternacionalRequest))
    as element(ns0:opTransferenciaInternacionalSolicitud) {
        <ns0:opTransferenciaInternacionalSolicitud>
            <ns1:contextoTransaccional>
                <ns1:codCanalOriginador>1</ns1:codCanalOriginador>
            </ns1:contextoTransaccional>
            <ns1:transferenciaInternacional>
                <ns1:cuentaDebito>
                    <ns1:codCuentaHabiente>{ data($transferenciaInternacionalRequest/DEBIT_ACCOUNT) }</ns1:codCuentaHabiente>
                </ns1:cuentaDebito>
                <ns1:monedaDebito>
                    <ns1:valSimboloMoneda>{ data($transferenciaInternacionalRequest/DEBIT_CURRENCY) }</ns1:valSimboloMoneda>
                </ns1:monedaDebito>
                <ns1:paisDestino>
                    <ns1:codPais>{ data($transferenciaInternacionalRequest/DESTINATION_COUNTRY) }</ns1:codPais>
                </ns1:paisDestino>
                <ns1:monedaCtaDestino>
                    {
                    	if (fn:contains(data($transferenciaInternacionalRequest/DESTINATION_CURRENCY),('USD'))) then
                    		<ns1:valSimboloMoneda>{ 'USD' }</ns1:valSimboloMoneda>
                    	else if (fn:contains(data($transferenciaInternacionalRequest/DESTINATION_CURRENCY),('EUR'))) then                       
                    		<ns1:valSimboloMoneda>{ 'EUR' }</ns1:valSimboloMoneda>
                    	else if (fn:contains(data($transferenciaInternacionalRequest/DESTINATION_CURRENCY),('NIO'))) then                       
                    		<ns1:valSimboloMoneda>{ 'NIO' }</ns1:valSimboloMoneda>
                        else
                        	<ns1:valSimboloMoneda>{ 'USD' }</ns1:valSimboloMoneda>
                    }
                </ns1:monedaCtaDestino>
                <ns1:bancoIntermediario>
                    {
                        for $INTERMEDIARY_BANK_NAME in $transferenciaInternacionalRequest/INTERMEDIARY_BANK_NAME
                        return
                            <ns1:nombreBanco>{ data($INTERMEDIARY_BANK_NAME) }</ns1:nombreBanco>
                    }
                    <ns1:direccionBanco>
                        {
                            for $INTERMEDIARY_BANK_ADDRESS in $transferenciaInternacionalRequest/INTERMEDIARY_BANK_ADDRESS
                            return
                                <ns1:valDireccion>{ data($INTERMEDIARY_BANK_ADDRESS) }</ns1:valDireccion>
                        }
                    </ns1:direccionBanco>
                    <ns1:codTipoBanco>{ data($transferenciaInternacionalRequest/INTERMEDIARY_BANK_CODE_TYPE) }</ns1:codTipoBanco>
                    <ns1:codSABanco>{ data($transferenciaInternacionalRequest/INTERMEDIARY_BANK_CODE) }</ns1:codSABanco>
                    <ns1:instruccionBanco>{ data($transferenciaInternacionalRequest/INTERMEDIARY_BANK_INSTRUCTIONS) }</ns1:instruccionBanco>
                </ns1:bancoIntermediario>
                <ns1:bancoBeneficiario>
                    <ns1:nombreBanco>{ data($transferenciaInternacionalRequest/BENEF_BANK_NAME) }</ns1:nombreBanco>
                    <ns1:direccionBanco>
                        <ns1:valCodigoPostal>{ data($transferenciaInternacionalRequest/BENEF_BANK_POSTAL_CODE) }</ns1:valCodigoPostal>
                        <ns1:valDireccion>{ data($transferenciaInternacionalRequest/BENEF_BANK_ADDRESS) }</ns1:valDireccion>
                        <ns1:codDepartamento>{ data($transferenciaInternacionalRequest/BENEF_BANK_STATE) }</ns1:codDepartamento>
                        <ns1:ciudad>
                            <ns1:codCiudad>{ data($transferenciaInternacionalRequest/BENEF_BANK_CITY) }</ns1:codCiudad>
                        </ns1:ciudad>
                    </ns1:direccionBanco>
                    <ns1:codTipoBanco>{ data($transferenciaInternacionalRequest/BENEF_BANK_CODE_TYPE) }</ns1:codTipoBanco>
                    <ns1:codSABanco>{ data($transferenciaInternacionalRequest/BENEF_BANK_CODE) }</ns1:codSABanco>
                    <ns1:paisBanco>
                        <ns1:codPais>{ data($transferenciaInternacionalRequest/BENEF_BANK_COUNTRY) }</ns1:codPais>
                    </ns1:paisBanco>
                    <ns1:cuentaBanco>
                        <ns1:codCuentaHabiente>{ data($transferenciaInternacionalRequest/BENEF_BANK_INT_ACCOUNT) }</ns1:codCuentaHabiente>
                    </ns1:cuentaBanco>
                </ns1:bancoBeneficiario>
                <ns1:beneficiario>
                    <ns1:nombreBeneficiario>{ data($transferenciaInternacionalRequest/BENEFICIARY_NAME) }</ns1:nombreBeneficiario>
                    <ns1:cuentaBeneficiario>
                        <ns1:codCuentaHabiente>{ data($transferenciaInternacionalRequest/BENEFICIARY_ACCOUNT) }</ns1:codCuentaHabiente>
                    </ns1:cuentaBeneficiario>
                    <ns1:direccionBeneficiario>
                        <ns1:valCodigoPostal>{ data($transferenciaInternacionalRequest/BENEFICIARY_POSTAL_CODE) }</ns1:valCodigoPostal>
                        <ns1:valDireccion>{ data($transferenciaInternacionalRequest/BENEFICIARY_ADDRESS) }</ns1:valDireccion>
                        <ns1:codDepartamento>{ data($transferenciaInternacionalRequest/BENEFICIARY_STATE) }</ns1:codDepartamento>
                        <ns1:ciudad>
                            <ns1:codCiudad>{ data($transferenciaInternacionalRequest/BENEFICIARY_CITY) }</ns1:codCiudad>
                        </ns1:ciudad>
                    </ns1:direccionBeneficiario>
                    <ns1:infoBeneficiario>{ data($transferenciaInternacionalRequest/BENEFICIARY_INFO) }</ns1:infoBeneficiario>
                </ns1:beneficiario>
                <ns1:montoTransferencia>{ data($transferenciaInternacionalRequest/TRANSFER_AMOUNT) }</ns1:montoTransferencia>
                <ns1:numeroReferenciaSO>{ data($transferenciaInternacionalRequest/INTERFACE_REFERENCE_NO) }</ns1:numeroReferenciaSO>
                <ns1:toperacion>P</ns1:toperacion>
                {
                    for $DESCRIPTION in $transferenciaInternacionalRequest/DESCRIPTION
                    return
                        <ns1:concepto>{ data($DESCRIPTION) }</ns1:concepto>
                }
            </ns1:transferenciaInternacional>
        </ns0:opTransferenciaInternacionalSolicitud>
};

declare variable $transferenciaInternacionalRequest as element(ns2:transferenciaInternacionalRequest) external;

xf:transferenciaIntlNIIn($transferenciaInternacionalRequest)
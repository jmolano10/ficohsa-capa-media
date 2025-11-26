xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$registroPagoNominaCobis" element="ns0:registroPagoNominaCobis" location="../xsd/registroPagoNominaCobisTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/OSB/RegistroPagoNominaCobis/xsd/insertaNominaColaboradores_sp.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RegistroPagoNominaCobis/xq/insertarNominaCobisIn/";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/insertaNominaColaboradores";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/registroPagoNominaCobisTypes";

declare function xf:insertarNominaCobisIn($registroPagoNominaCobis as element(ns0:registroPagoNominaCobis))
    as element(ns1:InputParameters) {
                <ns1:InputParameters>
        	<ns1:s_ssn></ns1:s_ssn>
        	<ns1:s_ssn_branch></ns1:s_ssn_branch>
        	<ns1:s_srv></ns1:s_srv>
        	<ns1:s_lsrv></ns1:s_lsrv>
        	<ns1:s_user></ns1:s_user>
        	<ns1:s_sesn></ns1:s_sesn>
        	<ns1:s_term></ns1:s_term>
        	<ns1:s_date></ns1:s_date>
        	<ns1:s_ofi></ns1:s_ofi>
        	<ns1:s_rol></ns1:s_rol>
        	<ns1:s_org_err></ns1:s_org_err>
        	<ns1:s_error></ns1:s_error>
        	<ns1:s_sev></ns1:s_sev>
        	<ns1:s_msg></ns1:s_msg>
        	<ns1:s_org></ns1:s_org>
        	<ns1:t_corr></ns1:t_corr>
        	<ns1:t_ssn_corr></ns1:t_ssn_corr>
        	<ns1:t_debug></ns1:t_debug>
        	<ns1:t_file></ns1:t_file>
        	<ns1:t_from></ns1:t_from>
        	<ns1:t_rty></ns1:t_rty>
        	<ns1:t_ejec></ns1:t_ejec>
        	<ns1:t_trn></ns1:t_trn>
            <ns1:i_tipo_registro>{ data($registroPagoNominaCobis/TYPE_REGISTER) }</ns1:i_tipo_registro>
            <ns1:i_secuencial_nomina>{ data($registroPagoNominaCobis/BATCH_NUMBER) }</ns1:i_secuencial_nomina>
            <ns1:i_total_registros>{ data($registroPagoNominaCobis/TOTAL_RECORDS) }</ns1:i_total_registros>
            <ns1:i_valor_total>{ data($registroPagoNominaCobis/TOTAL_VALUE) }</ns1:i_valor_total>
            <ns1:i_empresa>{ data($registroPagoNominaCobis/COMPANY_CODE) }</ns1:i_empresa>
            <ns1:i_secuencial_reg>{ data($registroPagoNominaCobis/TRANSACTION_NUMBER) }</ns1:i_secuencial_reg>
            <ns1:i_tipo_cuenta>{ data($registroPagoNominaCobis/ACCOUNT_TYPE) }</ns1:i_tipo_cuenta>
            <ns1:i_cuenta>{ data($registroPagoNominaCobis/ACCOUNT) }</ns1:i_cuenta>
            <ns1:i_moneda>{ data($registroPagoNominaCobis/CURRENCY) }</ns1:i_moneda>
            <ns1:i_monto>{ data($registroPagoNominaCobis/AMOUNT) }</ns1:i_monto>
            <ns1:i_concepto>{ data($registroPagoNominaCobis/CONCEPT) }</ns1:i_concepto>
            <ns1:i_cedula>{ data($registroPagoNominaCobis/IDENTIFICATION_NUMBER) }</ns1:i_cedula>
            <ns1:i_texto>{ data($registroPagoNominaCobis/TEXT) }</ns1:i_texto>
            <ns1:i_fecha>{ current-date() }</ns1:i_fecha>
        </ns1:InputParameters>
};

declare variable $registroPagoNominaCobis as element(ns0:registroPagoNominaCobis) external;

xf:insertarNominaCobisIn($registroPagoNominaCobis)

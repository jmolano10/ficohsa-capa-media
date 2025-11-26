(:: pragma bea:global-element-parameter parameter="$outputParametersInfoPersona" element="ns0:OutputParameters" location="../../../BusinessServices/FPC/consultaInformacionPersona/xsd/consultaInformacionPersonaFPC_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaFondoPensionesResponse" location="../xsd/consultaFondoPensionesTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaFondoPensionesTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaInformacionPersonaFPC";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaFondoPensiones/xq/consultaFondoPensiones_FPCHNOut/";

declare function local:format-date-from-FPC($textdate as xs:string) as xs:string
{
	fn:concat(fn:substring($textdate,1,4),fn:substring($textdate,6,2),fn:substring($textdate,9,2),fn:substring($textdate,12,2),fn:substring($textdate,15,2),fn:substring($textdate,18,2))
};

declare function xf:consultaFondoPensiones_FPCHNOut($accountNumber as xs:string,
    $outputParametersInfoPersona as element(ns0:OutputParameters))
    as element(ns1:consultaFondoPensionesResponse) {
        <ns1:consultaFondoPensionesResponse>
            <ns1:ACCOUNT_NUMBER>{ $accountNumber }</ns1:ACCOUNT_NUMBER>
            {
                for $PC_COD_PERSONA_SYSDE in $outputParametersInfoPersona/ns0:PC_COD_PERSONA_SYSDE
                return
                    <ns1:CUSTOMER_ID>{ data($PC_COD_PERSONA_SYSDE) }</ns1:CUSTOMER_ID>
            }
            {
                for $PC_NOMBRE_COMPLETO in $outputParametersInfoPersona/ns0:PC_NOMBRE_COMPLETO
                return
                    <ns1:CUSTOMER_NAME>{ data($PC_NOMBRE_COMPLETO) }</ns1:CUSTOMER_NAME>
            }
            {
                for $PC_COD_PRODUCTO in $outputParametersInfoPersona/ns0:PC_COD_PRODUCTO
                return
                    <ns1:PRODUCT_CODE>{ data($PC_COD_PRODUCTO) }</ns1:PRODUCT_CODE>
            }
            {
                for $PC_NOM_PRODUCTO in $outputParametersInfoPersona/ns0:PC_NOM_PRODUCTO
                return
                    <ns1:PRODUCT_NAME>{ data($PC_NOM_PRODUCTO) }</ns1:PRODUCT_NAME>
            }
            {
                for $PC_COD_SUBPRODUCTO in $outputParametersInfoPersona/ns0:PC_COD_SUBPRODUCTO
                return
                    <ns1:SUB_PRODUCT_CODE>{ data($PC_COD_SUBPRODUCTO) }</ns1:SUB_PRODUCT_CODE>
            }
            {
                for $PD_FEC_INGRE_FONDO in $outputParametersInfoPersona/ns0:PD_FEC_INGRE_FONDO
                return
                    <ns1:OPENING_DATE>{ local:format-date-from-FPC(data($PD_FEC_INGRE_FONDO)) }</ns1:OPENING_DATE>
            }
            {
                for $PC_FRECUENCIA in $outputParametersInfoPersona/ns0:PC_FRECUENCIA
                return
                    <ns1:FREQUENCY>{ fn:upper-case(data($PC_FRECUENCIA)) }</ns1:FREQUENCY>
            }
            {
                for $PC_FORMA_APORTACION in $outputParametersInfoPersona/ns0:PC_FORMA_APORTACION
                return
                    <ns1:PAYMENT_METHOD>{ fn:upper-case(data($PC_FORMA_APORTACION)) }</ns1:PAYMENT_METHOD>
            }
            {
                for $PN_MON_APORTE_SEGURO in $outputParametersInfoPersona/ns0:PN_MON_APORTE_SEGURO
                return
                    <ns1:INSURED_AMOUNT>{ data($PN_MON_APORTE_SEGURO) }</ns1:INSURED_AMOUNT>
            }
            {
                for $PN_MON_APORTE_ACORDAD in $outputParametersInfoPersona/ns0:PN_MON_APORTE_ACORDAD
                return
                    <ns1:CONTRIBUTION_AMOUNT>{ data($PN_MON_APORTE_ACORDAD) }</ns1:CONTRIBUTION_AMOUNT>
            }
            {
                for $PN_MON_APORTE_ULT_FEC in $outputParametersInfoPersona/ns0:PN_MON_APORTE_ULT_FEC
                return
                    <ns1:LAST_CONTRIBUTION_AMOUNT>{ data($PN_MON_APORTE_ULT_FEC) }</ns1:LAST_CONTRIBUTION_AMOUNT>
            }
            {
                for $PD_FEC_ULTIMO_APORTE in $outputParametersInfoPersona/ns0:PD_FEC_ULTIMO_APORTE
                return
                    <ns1:LAST_CONTRIBUTION_DATE>{ local:format-date-from-FPC(data($PD_FEC_ULTIMO_APORTE)) }</ns1:LAST_CONTRIBUTION_DATE>
            }
            {
                for $PD_FEC_PROXIM_APORTE in $outputParametersInfoPersona/ns0:PD_FEC_PROXIM_APORTE
                return
                    <ns1:NEXT_CONTRIBUTION_DATE>{ local:format-date-from-FPC(data($PD_FEC_PROXIM_APORTE)) }</ns1:NEXT_CONTRIBUTION_DATE>
            }
            {
                for $PN_MON_ULT_APORTE_EXT in $outputParametersInfoPersona/ns0:PN_MON_ULT_APORTE_EXT
                return
                    <ns1:LAST_EXTRA_CONTRIBUTION_AMOUNT>{ data($PN_MON_ULT_APORTE_EXT) }</ns1:LAST_EXTRA_CONTRIBUTION_AMOUNT>
            }
            {
                let $PT_BENEFICIARIOS := $outputParametersInfoPersona/ns0:PT_BENEFICIARIOS
                return
                    <ns1:BENEFICIARY_INFO>
                        {
                            for $PT_BENEFICIARIOS_ITEM in $PT_BENEFICIARIOS/ns0:PT_BENEFICIARIOS_ITEM
                            return
                                <ns1:BENEFICIARY_ITEM>
                                    <ns1:FULL_NAME>{ data($PT_BENEFICIARIOS_ITEM/ns0:NOMBRE) }</ns1:FULL_NAME>
                                    {
                                        for $PARENTESCO in $PT_BENEFICIARIOS_ITEM/ns0:PARENTESCO
                                        return
                                            <ns1:RELATIONSHIP>{ data($PARENTESCO) }</ns1:RELATIONSHIP>
                                    }
                                </ns1:BENEFICIARY_ITEM>
                        }
                    </ns1:BENEFICIARY_INFO>
            }
        </ns1:consultaFondoPensionesResponse>
};

declare variable $accountNumber as xs:string external;
declare variable $outputParametersInfoPersona as element(ns0:OutputParameters) external;

xf:consultaFondoPensiones_FPCHNOut($accountNumber,
    $outputParametersInfoPersona)
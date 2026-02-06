xquery version "2004-draft";
(:: pragma bea:local-element-parameter parameter="$OutputParameters" type="ns1:OutputParameters" location="../../../BusinessServices/DEI/valoresDeGuiaPago/xsd/valoresDeGuiaPago_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:valoresDeGuiaPagoResponse" location="../../TributosDEI/xsd/tributosTypes.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/valoresDeGuiaPago";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/tributosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValoresDeGuiaPagoDEI/xq/valoresDeGuiaPagoDEIOut/";

declare function xf:valoresDeGuiaPagoDEIOut($OutputParameters as element(ns1:OutputParameters))
    as element(ns0:valoresDeGuiaPagoResponse) {
        <ns0:valoresDeGuiaPagoResponse>
            {
                for $ESTADO in $OutputParameters/ns1:PT_GUIAPAGORESULT/ns1:ESTADO						
                return
                    <STATUS>{ data($ESTADO) }</STATUS>
            }
            {    
                for $DescEstado in $OutputParameters/ns1:PV_DESCRIPCIONESTADO
                return
                <STATUS_DESC>{ data($DescEstado) }</STATUS_DESC>
            }
            {
                for $IMPUESTOS in $OutputParameters/ns1:PT_GUIAPAGORESULT/ns1:IMPUESTOS
                return
                    <TAXES>
                        {
                            for $ITEM in $IMPUESTOS/ns1:ITEM
                            return
                                <TAX>
                                    {
                                        for $IMPUESTO in $ITEM/ns1:IMPUESTO
                                        return
                                            <CODE>{ data($IMPUESTO) }</CODE>
                                    }
                                    {
                                        for $IMPUESTODESC in $ITEM/ns1:IMPUESTODESC
                                        return
                                            <TAX_DESCRIPTION>{ data($IMPUESTODESC) }</TAX_DESCRIPTION>
                                    }
                                    {
                                        for $CONCEPTO in $ITEM/ns1:CONCEPTO
                                        return
                                            <TAX_CONCEPT>{ data($CONCEPTO) }</TAX_CONCEPT>
                                    }
                                    {
                                        for $CONCEPTODESC in $ITEM/ns1:CONCEPTODESC
                                        return
                                            <CONCEPT_DESCRIPTION>{ data($CONCEPTODESC) }</CONCEPT_DESCRIPTION>
                                    }
                                    {
                                        for $VALORIMPUESTO in $ITEM/ns1:VALORIMPUESTO
                                        return
                                            <TAX_VALUE>{ data($VALORIMPUESTO) }</TAX_VALUE>
                                    }
                                    {
                                        for $VALORMULTA in $ITEM/ns1:VALORMULTA
                                        return
                                            <TAX_PENALTY>{ data($VALORMULTA) }</TAX_PENALTY>
                                    }
                                    {
                                        for $VALORRECARGO in $ITEM/ns1:VALORRECARGO
                                        return
                                            <TAX_SURCHARGE>{ data($VALORRECARGO) }</TAX_SURCHARGE>
                                    }
                                    {
                                        for $VALORINTERES in $ITEM/ns1:VALORINTERES
                                        return
                                            <TAX_INTEREST>{ data($VALORINTERES) }</TAX_INTEREST>
                                    }
                                </TAX>
                        }
                    </TAXES>
            }
        </ns0:valoresDeGuiaPagoResponse>
};

declare variable $OutputParameters as element(ns1:OutputParameters) external;

xf:valoresDeGuiaPagoDEIOut($OutputParameters)
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../../BusinessServices/ABK/consultarLoteDepRef/xsd/consultarLoteDepRef_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarLoteDepRef";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaLoteDepRef/xq/ConsultaLoteDepRefHeaderOut/";

declare function xf:ConsultaLoteDepRefHeaderOut($outputParameters1 as element(ns1:OutputParameters))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            <successIndicator>
            	{
                    if (data($outputParameters1/ns1:PV_CODRESPUESTA) = "SUCCESS") then
                        ("Success")
                    else 
                        data($outputParameters1/ns1:PV_CODRESPUESTA)
                }
			</successIndicator>
            {
                for $PV_MSJRESPUESTA in $outputParameters1/ns1:PV_MSJRESPUESTA
                return
                    <messages>{ data($PV_MSJRESPUESTA) }</messages>
            }
        </ns0:ResponseHeader>
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;

xf:ConsultaLoteDepRefHeaderOut($outputParameters1)
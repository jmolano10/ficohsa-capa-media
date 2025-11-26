(:: pragma bea:global-element-parameter parameter="$depositoEfectivoMLME" element="ns0:DepositoEfectivoMLME" location="../../xsds/DepositoEfecMonLocalEnMonExtranjera/DepositoEfecMonLocalEnMonExtranjera.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$depositoEfectivoMLMEResponse" element="ns0:DepositoEfectivoMLMEResponse" location="../../xsds/Depositos/XMLSchema_-420276392.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadeusuariosdelsistema" location="../../xsds/Core/XMLSchema_1632682327.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/DepositoEfecMonLocalEnMonExtranjera/ConsultaDeUsuariosDelSistemaIn/";

declare function xf:ConsultaDeUsuariosDelSistemaIn($depositoEfectivoMLME as element(ns0:DepositoEfectivoMLME),
    $depositoEfectivoMLMEResponse as element(ns0:DepositoEfectivoMLMEResponse))
    as element(ns0:Consultadeusuariosdelsistema) {
        <ns0:Consultadeusuariosdelsistema>
            {
                for $WebRequestCommon in $depositoEfectivoMLME/WebRequestCommon
                return
                    <WebRequestCommon>{ $WebRequestCommon/@* , $WebRequestCommon/node() }</WebRequestCommon>
            }
            <WSUSERType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    {
                        for $AUTHORISER in $depositoEfectivoMLMEResponse/TELLERType/AUTHORISER
                        return
                            <criteriaValue>{ fn:tokenize(data($AUTHORISER), "_")[2] }</criteriaValue>
                    }
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSUSERType>            
        </ns0:Consultadeusuariosdelsistema>
};

declare variable $depositoEfectivoMLME as element(ns0:DepositoEfectivoMLME) external;
declare variable $depositoEfectivoMLMEResponse as element(ns0:DepositoEfectivoMLMEResponse) external;

xf:ConsultaDeUsuariosDelSistemaIn($depositoEfectivoMLME,
    $depositoEfectivoMLMEResponse)
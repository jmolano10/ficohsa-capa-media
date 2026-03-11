xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="T24WebServicesImpl";
(:: import schema at "../Schemas/ObtenerTicket.xsd" ::)
declare namespace ns3="https://www.ficohsa.com/honduras/user";
(:: import schema at "../../SBHN_Transfer_Commons/Schemas/UserLoginT24.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/regional/transfer";
(:: import schema at "../Schemas/GetTicketTypes.xsd" ::)

declare variable $input as element() (:: schema-element(ns1:getTicket) ::) external;
declare variable $userConnInfo as element() (:: schema-element(ns3:connInfoElement) ::) external;

declare function local:funcGetTicketToT24($input as element() (:: schema-element(ns1:getTicket) ::), 
                                          $userConnInfo as element() (:: schema-element(ns3:connInfoElement) ::)) 
                                          as element() (:: schema-element(ns2:getTicket) ::) {
    <ns2:getTicket>
        <WebRequestCommon>
            <userName>{fn:data($userConnInfo/ns3:username)}</userName>
            <password>{fn:data($userConnInfo/ns3:password)}</password>
            <company></company>
        </WebRequestCommon>
        <WSQRYTICKETType>
            <enquiryInputCollection>
                <columnName>@ID</columnName>
                <criteriaValue>{fn:data($input/Ticket)}</criteriaValue>
                <operand>EQ</operand>
            </enquiryInputCollection>
        </WSQRYTICKETType>
    </ns2:getTicket>
};

local:funcGetTicketToT24($input, $userConnInfo)

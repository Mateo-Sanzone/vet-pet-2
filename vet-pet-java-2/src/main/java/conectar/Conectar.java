/*



<%
                        try {

                            Class.forName("com.mysql.jdbc.Driver");
                            con = DriverManager.getConnection("jdbc:mysql://localhost/usuarios?user=root&password=");
                            st = con.createStatement();
                            rs = st.executeQuery("SELECT * FROM usuarios;");

                            while (rs.next()) {
                    %>

                    <tr>
                        <th scope="row"><%= rs.getString(1)%></th>
                        <td><%= rs.getString(2)%></td>
                        <td><%= rs.getString(3)%></td>
                    </tr>

                    <%
                        }

                    }catch (Exception e) {
                        out.print("ERROR en mysql "+e);
                    } 
                    %>




*/

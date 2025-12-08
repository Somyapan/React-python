import React, { useState, useEffect } from "react";

const API_BASE =
  import.meta.env.VITE_API_BASE_URL || "http://localhost:8000";

export default function App() {
  const [form, setForm] = useState({
    name: "",
    email: "",
    course: "",
    age: ""
  });
  const [students, setStudents] = useState([]);
  const [loading, setLoading] = useState(false);
  const [msg, setMsg] = useState("");
  const [error, setError] = useState("");

  const fetchStudents = async () => {
    try {
      const res = await fetch(`${API_BASE}/students`);
      if (!res.ok) throw new Error("Failed to fetch students");
      const data = await res.json();
      setStudents(data);
      setError("");
    } catch (err) {
      console.error(err);
      setError("Error fetching students");
    }
  };

  useEffect(() => {
    fetchStudents();
  }, []);

  const handleChange = (e) => {
    const { name, value } = e.target;
    setForm((prev) => ({ ...prev, [name]: value }));
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setLoading(true);
    setMsg("");
    setError("");

    try {
      const res = await fetch(`${API_BASE}/students`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ ...form, age: Number(form.age) })
      });

      if (!res.ok) {
        const errData = await res.json();
        throw new Error(errData.detail || "Failed to submit");
      }

      const saved = await res.json();
      setStudents((prev) => [...prev, saved]);
      setMsg("✅ Student saved successfully!");
      setForm({ name: "", email: "", course: "", age: "" });
      setTimeout(() => setMsg(""), 3000);
    } catch (err) {
      console.error(err);
      setError(`❌ Error: ${err.message}`);
    } finally {
      setLoading(false);
    }
  };

  return (
    <div style={{ maxWidth: 600, margin: "30px auto", fontFamily: "sans-serif", padding: "20px" }}>
      <h1>📚 Student Registration</h1>

      {error && <div style={{ color: "red", marginBottom: "10px", padding: "10px", backgroundColor: "#ffebee", borderRadius: "4px" }}>{error}</div>}
      {msg && <div style={{ color: "green", marginBottom: "10px", padding: "10px", backgroundColor: "#e8f5e9", borderRadius: "4px" }}>{msg}</div>}

      <form onSubmit={handleSubmit} style={{ display: "grid", gap: "10px", border: "1px solid #ccc", padding: "20px", borderRadius: "8px", backgroundColor: "#f9f9f9" }}>
        <input
          name="name"
          placeholder="Full Name"
          value={form.name}
          onChange={handleChange}
          required
          style={{ padding: "10px", border: "1px solid #ddd", borderRadius: "4px" }}
        />
        <input
          name="email"
          placeholder="Email"
          type="email"
          value={form.email}
          onChange={handleChange}
          required
          style={{ padding: "10px", border: "1px solid #ddd", borderRadius: "4px" }}
        />
        <input
          name="course"
          placeholder="Course Name"
          value={form.course}
          onChange={handleChange}
          required
          style={{ padding: "10px", border: "1px solid #ddd", borderRadius: "4px" }}
        />
        <input
          name="age"
          placeholder="Age"
          type="number"
          value={form.age}
          onChange={handleChange}
          required
          style={{ padding: "10px", border: "1px solid #ddd", borderRadius: "4px" }}
        />

        <button 
          type="submit" 
          disabled={loading}
          style={{ 
            padding: "10px", 
            backgroundColor: loading ? "#ccc" : "#4CAF50", 
            color: "white", 
            border: "none", 
            borderRadius: "4px", 
            cursor: loading ? "not-allowed" : "pointer",
            fontSize: "16px",
            fontWeight: "bold"
          }}
        >
          {loading ? "⏳ Saving..." : "✅ Submit"}
        </button>
      </form>

      <h2 style={{ marginTop: "30px" }}>📋 All Students ({students.length})</h2>
      {students.length === 0 && <p style={{ color: "#666" }}>No students yet.</p>}
      <ul style={{ listStyle: "none", padding: 0 }}>
        {students.map((s) => (
          <li key={s.id} style={{ padding: "10px", marginBottom: "10px", border: "1px solid #ddd", borderRadius: "4px", backgroundColor: "#f5f5f5" }}>
            <strong>{s.name}</strong> ({s.email})<br />
            Course: {s.course} | Age: {s.age}
          </li>
        ))}
      </ul>
    </div>
  );
}
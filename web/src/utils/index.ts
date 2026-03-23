/* eslint-disable */

export async function FetchNUI(action: string, payload: Record<string, any> = {}): Promise<any> {
  const options = {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify(payload),
  };

  const url = `https://0r-multicharacterv3/${action}`;

  try {
    const response = await fetch(url, options);

    return await response.json();
  } catch (e) {
    return false;
  }
}
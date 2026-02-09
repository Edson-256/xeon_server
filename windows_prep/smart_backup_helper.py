import os
import datetime
from google import genai
import getpass

def main():
    print("--- Gemini Smart Backup Helper ---")
    
    # 1. Setup API Key
    api_key = os.environ.get("GOOGLE_API_KEY")
    if not api_key:
        print("GOOGLE_API_KEY not found in environment variables.")
        api_key = getpass.getpass("Please paste your Google Gemini API Key: ")
    
    if not api_key:
        print("Error: API Key is required.")
        return

    # 2. Configure Client
    try:
        client = genai.Client(api_key=api_key)
    except Exception as e:
        print(f"Error initializing Gemini client: {e}")
        return

    # 3. Define Source Directory
    # Default to IIS wwwroot, but allow override
    default_src = r"C:\inetpub\wwwroot"
    src_dir = input(f"Enter source directory to scan [{default_src}]: ").strip()
    if not src_dir:
        src_dir = default_src

    if not os.path.exists(src_dir):
        print(f"Error: Directory {src_dir} does not exist.")
        return

    # 4. Scan Directory
    print(f"Scanning {src_dir}...")
    file_list = []
    total_size = 0
    file_types = {}

    for root, dirs, files in os.walk(src_dir):
        for file in files:
            path = os.path.join(root, file)
            size = os.path.getsize(path)
            total_size += size
            file_list.append(file)
            
            ext = os.path.splitext(file)[1].lower()
            file_types[ext] = file_types.get(ext, 0) + 1

    print(f"Found {len(file_list)} files. Total size: {total_size / (1024*1024):.2f} MB")
    
    # 5. Generate AI Summary
    print("Asking Gemini to generate migration notes...")
    
    prompt = f"""
    I am migrating a legacy Windows Server 2016 web server to Ubuntu 24.04.
    I am backing up the files now.
    
    Here is the summary of the files found:
    Total Files: {len(file_list)}
    File Types breakdown: {file_types}
    
    Some filenames: {file_list[:50]} (truncated if too long)
    
    Please generate a 'migration_manifest.txt' content that I should save with the backup.
    The manifest should:
    1. Summarize the type of content (static site, app, mixed files).
    2. Suggest specific things I should look out for when moving these file types to Linux (e.g. case sensitivity, path separators).
    3. Be encouraging about the migration.
    """

    try:
        response = client.models.generate_content(
            model="gemini-2.0-flash",
            contents=prompt
        )
        
        manifest_content = response.text
        
        # Save to file
        output_file = "migration_manifest.txt"
        with open(output_file, "w", encoding="utf-8") as f:
            f.write(manifest_content)
            
        print(f"--- Success! ---")
        print(f"Gemini has generated a migration summary: {output_file}")
        print("You should include this file in your ZIP backup.")
        print("Content Preview:")
        print(manifest_content[:500] + "...")
        
    except Exception as e:
        print(f"Failed to generate AI content: {e}")

if __name__ == "__main__":
    main()

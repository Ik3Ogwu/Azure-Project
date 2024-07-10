import configparser
import requests
import pandas as pd

def fetch_qualifying_results(season, round):
    """Fetches the qualifying results for a specific Formula One race."""
    url = f"http://ergast.com/api/f1/{season}/{round}/qualifying.json"
    response = requests.get(url)
    if response.status_code != 200:
        raise Exception(f"Error fetching data from API: Status code {response.status_code}")
    data = response.json()
    return data

def parse_qualifying_results(data):
    """Parses the API response and extracts the relevant qualifying results."""
    races = data['MRData']['RaceTable']['Races']
    results = []
    for race in races:
        for result in race['QualifyingResults']:
            results.append({
                "Position": result['position'],
                "Driver": f"{result['Driver']['givenName']} {result['Driver']['familyName']}",
                "Constructor": result['Constructor']['name'],
                "Nationality": result['Driver']['nationality'],
                "Q1": result['Q1'],
                "Q2": result.get('Q2', 'N/A'),  # Q2 and Q3 might not be present for all results
                "Q3": result.get('Q3', 'N/A')
            })
    return results

def export_to_excel(results, season, round, filename_template="qualifying_results_{season}_{round}.xlsx"):
    """Exports the qualifying results to an Excel file, naming the file based on the season and round."""
    filename = filename_template.format(season=season, round=round)
    df = pd.DataFrame(results)
    with pd.ExcelWriter(filename) as writer:
        df.to_excel(writer, index=False)
    print(f"Data exported to {filename}")

if __name__ == "__main__":
    config = configparser.ConfigParser()
    config.read('config.ini')
    season = config['DEFAULT'].getint('Season')
    round = config['DEFAULT'].getint('Round')
    
    data = fetch_qualifying_results(season, round)
    results = parse_qualifying_results(data)
    export_to_excel(results, season, round)
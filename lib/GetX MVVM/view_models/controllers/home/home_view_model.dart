import 'package:book_buddy/GetX%20MVVM/data/response/status.dart';
import 'package:book_buddy/GetX%20MVVM/models/home/book_list_model.dart';
import 'package:book_buddy/GetX%20MVVM/models/home/user_list_model.dart';
import 'package:book_buddy/GetX%20MVVM/repository/home_repository/home_repository.dart';
import 'package:get/get.dart';

class HomeViewModel extends GetxController {
  final api = HomeRepository();
  RxInt currentIndex = 0.obs;

  final rxRequestStatus = Status.LOADING.obs;
  final userList = UserListModel().obs;
  final bookList = BookListModel().obs;

  void setrxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void setuserList(UserListModel _value) => userList.value = _value;
  void setbooksList(BookListModel _value) => bookList.value = _value;
  void setCurrentIndex(int _value) => currentIndex.value = _value;

  var showSearchBar = false.obs;

  void triggerSearchBar() {
    showSearchBar.value = true;
  }

  RxString error = ''.obs;

  void setError(String _value) => error.value = _value;

  final List<String> genres = [
    "Adventure",
    "Africa",
    "African American Writers",
    "Ainslee's",
    "American Revolutionary War",
    "Anarchism",
    "Animal",
    "Animals-Domestic",
    "Animals-Wild",
    "Animals-Wild-Birds",
    "Animals-Wild-Insects",
    "Animals-Wild-Mammals",
    "Animals-Wild-Reptiles and Amphibians",
    "Animals-Wild-Trapping",
    "Anthropology",
    "Archaeology",
    "Architecture",
    "Argentina",
    "Armour's Monthly Cook Book",
    "Art",
    "Arthurian Legends",
    "Astounding Stories",
    "Astronomy",
    "Atheism",
    "Australia",
    "Bahá'í Faith",
    "Banned Books List from the American Library Association",
    "Banned Books from Anne Haight's list",
    "Barnavännen",
    "Bestsellers, American, 1895-1923",
    "Best Books Ever Listings",
    "Bibliomania",
    "Biographies",
    "Biology",
    "Bird-Lore",
    "Birds, Illustrated by Color Photography",
    "Blackwood's Edinburgh Magazine",
    "Boer War",
    "Botany",
    "British Law",
    "Buchanan's Journal of Man",
    "Buddhism",
    "Bulgaria",
    "Bulletin de Lille",
    "CIA World Factbooks",
    "Camping",
    "Canada",
    "Canon Law",
    "Celtic Magazine",
    "Chambers's Edinburgh Journal",
    "Chemistry",
    "Child's Own Book of Great Musicians",
    "Children's Anthologies",
    "Children's Biography",
    "Children's Book Series",
    "Children's Fiction",
    "Children's History",
    "Children's Instructional Books",
    "Children's Literature",
    "Children's Myths, Fairy Tales, etc.",
    "Children's Picture Books",
    "Children's Religion",
    "Children's Verse",
    "Christianity",
    "Christmas",
    "Classical Antiquity",
    "Contemporary Reviews",
    "Continental Monthly",
    "Cookbooks and Cooking",
    "Crafts",
    "Crime Fiction",
    "Crime Nonfiction",
    "Current History",
    "Czech",
    "Detective Fiction",
    "Dew Drops",
    "De Aarde en haar Volken",
    "Donahoe's Magazine",
    "Early English Text Society",
    "Ecology",
    "Education",
    "Egypt",
    "Engineering",
    "English Civil War",
    "Erotic Fiction",
    "Esperanto",
    "Famous Scots Series",
    "Fantasy",
    "Folklore",
    "Forestry",
    "France",
    "Garden and Forest",
    "General Fiction",
    "Geology",
    "Germany",
    "German Language Books",
    "Godey's Lady's Book",
    "Golden Days for Boys and Girls",
    "Gothic Fiction",
    "Graham's Magazine",
    "Greece",
    "Harper's New Monthly Magazine",
    "Harper's Young People",
    "Harvard Classics",
    "Hinduism",
    "Historical Fiction",
    "Horror",
    "Horticulture",
    "Humor",
    "Illustrators",
    "India",
    "Islam",
    "Italy",
    "Judaism",
    "Journal of Entomology and Zoology",
    "L'Illustration",
    "Language Education",
    "Latter Day Saints",
    "Lippincott's Magazine",
    "Little Folks",
    "London Medical Gazette",
    "Love",
    "Manufacturing",
    "Maps and Cartography",
    "Masterpieces in Colour",
    "Mathematics",
    "McClure's Magazine",
    "Medicine",
    "Mediæval Town Series",
    "Microbiology",
    "Microscopy",
    "Mother Earth",
    "Movie Books",
    "Mrs Whittelsey's Magazine for Mothers and Daughters",
    "Music",
    "Mycology",
    "Mystery Fiction",
    "Mythology",
    "Napoleonic(Bookshelf)",
    "Native America",
    "Natural History",
    "New Zealand",
    "Northern Nut Growers Association",
    "Norway",
    "Notes and Queries",
    "Noteworthy Trials(Bookshelf)",
    "One Act Plays",
    "Opera",
    "Our Young Folks",
    "Paganism",
    "Philosophy",
    "Photography",
    "Physics",
    "Physiology",
    "Pirates, Buccaneers, Corsairs, etc.",
    "Plays",
    "Poetry",
    "Poetry, A Magazine of Verse",
    "Politics",
    "Popular Science Monthly",
    "Prairie Farmer",
    "Precursors of Science Fiction",
    "Project Gutenberg",
    "Psychology",
    "Punch",
    "Punchinello",
    "Racism",
    "Reference",
    "Romantic Fiction",
    "School Stories",
    "Science",
    "Science Fiction",
    "Science Fiction by Women",
    "Scientific American",
    "Scouts",
    "Scribner's Magazine",
    "Short Stories",
    "Slavery",
    "Sociology",
    "South Africa",
    "South America",
    "Spanish American War",
    "St. Nicholas Magazine for Boys and Girls",
    "Suffrage",
    "Technology",
    "The Aldine",
    "The American Architect and Building News",
    "The American Bee Journal",
    "The American Journal of Archaeology",
    "The American Missionary",
    "The American Quarterly Review",
    "The Arena",
    "The Argosy",
    "The Atlantic Monthly",
    "The Baptist Magazine",
    "The Bay State Monthly",
    "The Botanical Magazine",
    "The Brochure Series of Architectural Illustration",
    "The Catholic World",
    "The Christian Foundation",
    "The Church of England Magazine",
    "The Contemporary Review",
    "The Economist",
    "The Esperantist",
    "The Galaxy",
    "The Girls Own Paper",
    "The Great Round World And What Is Going On In It",
    "The Haslemere Museum Gazette",
    "The Idler",
    "The Illustrated War News",
    "The International Magazine of Literature, Art, and Science",
    "The Irish Ecclesiastical Record",
    "The Irish Penny Journal",
    "The Journal of Negro History",
    "The Knickerbocker",
    "The Mayflower",
    "The Menorah Journal",
    "The Mentor",
    "The Mirror of Literature, Amusement, and Instruction",
    "The Mirror of Taste, and Dramatic Censor",
    "The National Preacher",
    "The North American Medical and Surgical Journal",
    "The Nursery",
    "The Philatelic Digital Library Project",
    "The Scrap Book",
    "The Speaker",
    "The Stars and Stripes",
    "The Strand Magazine",
    "The Unpopular Review",
    "The Writer",
    "The Yellow Book",
    "Transportation",
    "Travel",
    "US Civil War",
    "United Kingdom",
    "United States",
    "United States Law",
    "Western",
    "Witchcraft",
    "Women's Travel Journals",
    "Woodwork",
    "World War I",
    "World War II",
    "Zoology",
  ];

  RxString selectedGenre = ''.obs;

  void setSelectedGenre(String _value) => selectedGenre.value = _value;

  void selectGenre(String genre) {
    setSelectedGenre(genre);
  }

  RxString selectedLetter = 'All'.obs;
  RxList<String> filteredGenres = <String>[].obs;

  void updateFilteredGenres() {
    if (selectedLetter.value == 'All') {
      filteredGenres.value = genres;
    } else {
      filteredGenres.value =
          genres
              .where(
                (genre) => genre.toLowerCase().startsWith(
                  selectedLetter.value.toLowerCase(),
                ),
              )
              .toList();
    }
  }

  void setSelectedLetter(String letter) {
    selectedLetter.value = letter;
    updateFilteredGenres();
  }

  @override
  void onInit() {
    super.onInit();
    updateFilteredGenres(); // initialize with full list
  }

  void userListApi() {
    // setrxRequestStatus(Status.LOADING);
    api
        .usersListApi()
        .then((value) {
          setrxRequestStatus(Status.COMPLETETD);
          setuserList(value);
        })
        .onError((error, stackTrace) {
          setrxRequestStatus(Status.ERROR);
          setError(error.toString());
        });
  }

  void bookListApi(String query, String genre) {
    // Set loading status immediately
    setrxRequestStatus(Status.LOADING);

    if (query.isNotEmpty) {
      api
          .bookListQueryApi(query)
          .then((value) {
            setrxRequestStatus(Status.COMPLETETD);
            bookList(value);
          })
          .onError((error, stackTrace) {
            setrxRequestStatus(Status.ERROR);
            setError(error.toString());
          });
    } else if (genre.isNotEmpty) {
      api
          .bookListGenreApi(genre)
          .then((value) {
            setrxRequestStatus(Status.COMPLETETD);
            bookList(value);
          })
          .onError((error, stackTrace) {
            setrxRequestStatus(Status.ERROR);
            setError(error.toString());
          });
    } else {
      api
          .bookListApi()
          .then((value) {
            setrxRequestStatus(Status.COMPLETETD);
            bookList(value);
          })
          .onError((error, stackTrace) {
            setrxRequestStatus(Status.ERROR);
            setError(error.toString());
          });
    }
  }

  void refreshApi() {
    setrxRequestStatus(Status.LOADING);
    currentIndex.value = 0;
    setSelectedLetter('All');
    setSelectedGenre('');
    api
        .bookListApi()
        .then((value) {
          setrxRequestStatus(Status.COMPLETETD);
          bookList(value);
        })
        .onError((error, stackTrace) {
          setrxRequestStatus(Status.ERROR);
          setError(error.toString());
        });
  }
}
